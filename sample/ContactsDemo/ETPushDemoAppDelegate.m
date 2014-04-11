//
//  ETPushDemoAppDelegate.m
//  ContactsDemo
//
//  Created by Eddie Roger on 10/24/13.
//  Copyright (c) 2013 ExactTarget. All rights reserved.
//

#import "ETPushDemoAppDelegate.h"

/**
    This project will pull the SDK from the $ROOT/etpushsdk path, including headers. That is configured in the project settings. 
 */
#import "ETPush.h"

@implementation ETPushDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    /**
     This is a suggested implementation of the required configuration method. In this sample, the DEBUG flag is the differentiator between the development/sandbox and production instances of the Code@ExactTarget applications. If you are doing more complicated build configurations, this implementation may not work for you. The important thing is to ensure that the AppID and AccessToken you proivde match up to the Code@ET app you wish to send from and have the correct APNS certificates tied to.
     
     If you are unsure of your credentials or need help, please reach out to your Support partner. Likewise, if these services are not active in your account, log statements will be in your console to that effect. Please work with your sales or support rep if you have questions.
     */
#ifdef DEBUG
    [[ETPush pushManager] configureSDKWithAppID:@"" // The App ID from Code@ExactTarget
                                 andAccessToken:@""             // The Access Token from Code@ExactTarget
                                  withAnalytics:YES                                     // Whether or not you would like to use ExactTarget analytics services
                            andLocationServices:NO                                      // Whether or not you would like to use location-based alerts
                                  andCloudPages:NO];                                    // Whether or not you would like to use CloudPages.

#else
    [[ETPush pushManager] configureSDKWithAppID:@""
                                 andAccessToken:@""
                                  withAnalytics:YES
                            andLocationServices:NO
                                  andCloudPages:NO];

#endif
    
    /**
     This method delivers the launch options dictionary to the SDK. This is a required implementation step to ensure that pushes are delivered and processed by ExactTarget.
     */
    [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
    
    /**
     This method begins the push registration workflow. It indicates to iOS (and Apple) that this application wishes to send push messages. It is required for push, but the flags you provide are at your descretion (at least one is required).
     
     UIRemoteNotificationTypeAlert - This flag will ask for permission to show text to the user, in either Banner or an Alert.
     UIRemoteNotificationTypeBadge - This flag allows you to update the badge on the app icon
     UIRemoteNotificationTypeSound - This flag allows you to play a sound when the push is received.
     */
    [[ETPush pushManager] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    /**
     This method resets the application's badge icon to 0, and lets ExactTarget know that as well. It is required to clear the badge, and should be called here.
     */
    [[ETPush pushManager] resetBadgeCount];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 These are the Apple Push Notification Service Delegate methods. They are required for the Push lifecycle to work, and implementation of the ExactTarget methods within is required for ExactTarget's MobilePush to function as expected. You may copy this block directly to your code and modify it to your liking, or cherry-pick the required methods to your own implementation.
 */
#pragma mark - Push Notification Delegate Calls
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"Received a token! It is %@", deviceToken);
    
    /**
     This method informs the SDK of the received device token. It is required.
     */
     [[ETPush pushManager] registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to receive a token from Apple. Error: %@", [error localizedDescription]);
    
    /**
     This method lets the SDK know that registration failed. The NSLog statement isn't required, but you are highly encouraged to log this error, because it will help you get back to a working push implementation. It is a required method.
     */
    [[ETPush pushManager] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    /**
     This lets the SDK know that a push was delivered to the app, and passes in the userInfo dictionary so ExactTarget can process it and handle tracking opens. It is required.
     */
    [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
}

/**
 Starting with iOS 7, this method will be called if the app registers for background push notifications in the application's Capabilities section. The implementation within will largely depend on your work, but the ETPush method is required. 
 
 Note, please, that if you do imeplement this method, the other didRegisterRemoteNotification won't fire.
 */
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Received a background push: %@", userInfo);
    [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState]; // Required for ETPush
    
    /**
     Your implementation should ultimately call this method based on the discovery of if there was a successful fetch or not. Failure to do so will cause an app crash.
     */
    completionHandler(UIBackgroundFetchResultNewData);

}

/**
 This method handles local notifications, which the SDK may fire instead of a remote (push) notification. Implementation of this method is required if you are using ExactTarget location-based sending.
 */
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[ETPush pushManager] handleLocalNotification:notification]; // Required for ETPush
}

@end
