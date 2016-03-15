---
layout: page
title: "Interactive Notifications"
subtitle: "Display Interactive Notification Messages"
category: features
date: 2015-05-14 12:00:00
order: 8
---
Add buttons called **interactive notifications** to push notifications in your Mobile app. The Salesforce Marketing Cloud sends the category name for these interactive notifications in the message payload. This feature requires [enablement](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#interactiveNotifications) in the Marketing Cloud application.

Add the below to the AppDelegate.m didFinishLaunchingWithOptions function in order to register a category.

~~~

    #import "AppDelegate.h"
    #import "ETPush.h"

    // Code@ AppIDs and Access Tokens for the debug and production versions of your app
    // These values should be stored securely by your application or retrieved from a remote server
    static NSString *kETAppID_Debug       = @"change_this_to_your_debug_appId";
    static NSString *kETAccessToken_Debug = @"change_this_to_your_debug_accessToken";
    static NSString *kETAppID_Prod        = @"change_this_to_your_production_appId";
    static NSString *kETAccessToken_Prod  = @"change_this_to_your_production_accessToken";

    @implementation AppDelegate

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        BOOL successful = NO;
        NSError *error = nil;
    #ifdef DEBUG
        // Set to YES to enable logging while debugging
        [ETPush setETLoggerToRequiredState:YES];
        
        // configure and set initial settings of the JB4ASDK
        successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Debug
                                                  andAccessToken:kETAccessToken_Debug
                                                   withAnalytics:NO
                                             andLocationServices:NO
                                                   andCloudPages:NO
                                                 withPIAnalytics:NO
                                                           error:&error];
    #else
        // configure and set initial settings of the JB4ASDK
        successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Prod
                                                  andAccessToken:kETAccessToken_Prod
                                                   withAnalytics:NO
                                             andLocationServices:NO
                                                   andCloudPages:NO
                                                 withPIAnalytics:NO
                                                           error:&error];

if([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0)
  {
    if ( [[UIApplication sharedApplication] backgroundRefreshStatus] == UIBackgroundRefreshStatusAvailable )
      { [[UIApplication sharedApplication] setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum]; }
  }
    #endif
        //
        // if configureSDKWithAppID returns NO, check the error object for detailed failure info. See PushConstants.h for codes.
        // the features of the JB4ASDK will NOT be useable unless configureSDKWithAppID returns YES.
        //
        if (!successful) {
            dispatch_async(dispatch_get_main_queue(), ^{
                // something failed in the configureSDKWithAppID call - show what the error is
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Failed configureSDKWithAppID!", @"Failed configureSDKWithAppID!")
                                            message:[error localizedDescription]
                                           delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                  otherButtonTitles:nil] show];
            });
        }
        else {
            // create a user action
            UIMutableUserNotificationAction *actionButton1 = [[UIMutableUserNotificationAction alloc] init];
            actionButton1.identifier = @"actionButton1";
            actionButton1.title = @"View Offer";
            
            // Given seconds, not minutes, to run in the background
            actionButton1.activationMode = UIUserNotificationActivationModeBackground;
            actionButton1.destructive = NO;
            
            // If YES requires passcode, but does not unlock the device
            actionButton1.authenticationRequired = NO;
            
            // create a user action
            UIMutableUserNotificationAction *actionButton2 = [[UIMutableUserNotificationAction alloc] init];
            actionButton2.identifier = @"actionButton2";
            actionButton2.title = @"Add to Passbook";
            
            // Given seconds, not minutes, to run in the background
            actionButton2.activationMode = UIUserNotificationActivationModeBackground;
            actionButton2.destructive = NO;
            
            // If YES requires passcode, but does not unlock the device
            actionButton2.authenticationRequired = NO;
            
            // create a category to handle the button(s) - will be sent down with the APNS payload
            UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
            category.identifier = @"Example";
            
            // these will be the default context button(s)
            [category setActions:@[actionButton1, actionButton2] forContext:UIUserNotificationActionContextDefault];
            
            // these will be the minimal context button(s)
            [category setActions:@[actionButton1] forContext:UIUserNotificationActionContextMinimal];
            
            // make a set of all categories the app will support - just one for now
            NSSet *categories = [NSSet setWithObjects:category, nil];
            
            // register for push notifications - enable all notification types, one category
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound |
                                                    UIUserNotificationTypeAlert
                                                                                     categories:categories];
            
            // register for push notifications - enable all notification types, no categories
            [[ETPush pushManager] registerUserNotificationSettings:settings];
            [[ETPush pushManager] registerForRemoteNotifications];
            
            // inform the JB4ASDK of the launch options - possibly UIApplicationLaunchOptionsRemoteNotificationKey or UIApplicationLaunchOptionsLocalNotificationKey
            [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
        }
        
        return YES;
    }

    -(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
        { [[ETPush pushManager] refreshWithFetchCompletionHandler:completionHandler]; }

    - (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
    {
        // inform the JB4ASDK of the notification settings requested
        [[ETPush pushManager] didRegisterUserNotificationSettings:notificationSettings];
    }

    - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
    {
        // inform the JB4ASDK of the device token
        [[ETPush pushManager] registerDeviceToken:deviceToken];
    }

    -(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
    {
        // inform the JB4ASDK that the device failed to register and did not receive a device token
        [[ETPush pushManager] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
    }


    -(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
    {
        // inform the JB4ASDK that the device received a local notification
        [[ETPush pushManager] handleLocalNotification:notification];
    }

    - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler {
        
        // inform the JB4ASDK that the device received a remote notification
        [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
        
        // is it a silent push?
        if (userInfo[@"aps"][@"content-available"]) {
            // received a silent remote notification...
            
            // indicate a silent push
            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
        }
        else {
            // received a remote notification...
            
            // clear the badge
            [[ETPush pushManager] resetBadgeCount];
        }
        
        handler(UIBackgroundFetchResultNoData);
    }

    // handle category actions for local notifications
    - (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler
    {
        // inform the JB4ASDK that the device received a local notification
        [[ETPush pushManager] handleLocalNotification:notification];

        if ([identifier isEqualToString:@"actionButton1"]) {
            // specific code to handle the notification
        }
        else if ([identifier isEqualToString:@"actionButton2"]) {
            // specific code to handle the notification
        }
        
        completionHandler();
    }

    // handle category actions for remote notifications
    - (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
    {
        // inform the JB4ASDK that the device received a remote notification
        [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];

        if ([identifier isEqualToString:@"actionButton1"]) {
            // specific code to handle the notification
        }
        else if ([identifier isEqualToString:@"actionButton2"]) {
            // specific code to handle the notification
        }
        
        completionHandler();
    }

    @end
~~~