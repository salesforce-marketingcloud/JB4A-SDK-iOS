---
layout: page
title: "Implement SDK"
subtitle: "Implement SDK in your iOS App"
category: sdk-implementation
date: 2015-05-14 12:00:00
order: 1
---
In order to use the SDK in your Mobile app, complete the steps required to register a device with the Salesforce Marketing Cloud. This process ultimately connects the device to the MobilePush app you created in the [App Center]({{ site.baseurl }}/create-apps/create-apps-overview.html).

1. In your app development environment, copy the libJB4ASDK-X.X.X.a.a and the header files into your project. 
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/iossdk37.png" /><br/>
<br/>
1. Select **Project Settings**. 
1. Select **General**.
1. Add libJB4ASDK-X.X.X.a as a dependency.
1. Add code in the AppDelegate implementation class to bootstrap the Journey Builder for Apps SDK. Note that you must call configureSDKWithAppId and andAccessToken and provide values from <a href="https://code.exacttarget.com/" target="_blank">code@<a/>.

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
                                               withAnalytics:YES
                                         andLocationServices:YES
                                               andCloudPages:YES
                                             withPIAnalytics:YES
                                                       error:&error];
#else
    // configure and set initial settings of the JB4ASDK
    successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Prod
                                              andAccessToken:kETAccessToken_Prod
                                               withAnalytics:YES
                                         andLocationServices:YES
                                               andCloudPages:YES
                                             withPIAnalytics:YES
                                                       error:&error];
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
        // register for push notifications - enable all notification types, no categories
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound |
                                                UIUserNotificationTypeAlert
                                                                                 categories:nil];
        
        [[ETPush pushManager] registerUserNotificationSettings:settings];
        [[ETPush pushManager] registerForRemoteNotifications];
        
        // inform the JB4ASDK of the launch options - possibly UIApplicationLaunchOptionsRemoteNotificationKey or UIApplicationLaunchOptionsLocalNotificationKey
        [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
    }
    
    return YES;
}

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

@end
~~~

1.  Deploy and start your app on a physical test device. You can use an iOS simulator for testing, but the simulator will not receive push messages as part of the testing process.

Once you complete this process, you can build your application and send it push notifications from your Marketing Cloud account.