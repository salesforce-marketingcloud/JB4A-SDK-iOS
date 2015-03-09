/**
 * Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation and/or
 * other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software without
 * specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

//
//  PUDAppDelegate.m
//  PushDemo
//
//  Created by Matt Lathrop on 4/29/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDAppDelegate.h"

// Controllers
#import "PBWebViewController.h"
#import "PUDDiscountTableViewController.h"
#import "PUDNavigationController.h"
#import "PUDMessageReceivedTableViewController.h"
#import "PUDHomeViewController.h"
#import "PUDTabBarController.h"
// Libraries
#import "ETLandingPagePresenter.h"

//Constants
#import "PUDConstants.h"
#define PushConfigAlertViewTag 1

@interface PUDAppDelegate()

/**
 *  This is used to display the opendirect url when a message is received
 */
@property (nonatomic, strong) PBWebViewController *webViewController;

/**
 *  Used to display the discount code view when a discount code key is present
 */
@property (nonatomic, strong) PUDDiscountTableViewController *discountViewController;

@property (nonatomic, strong) PUDHomeViewController *homeViewController;
@property (nonatomic, strong) PUDTabBarController *tabbarViewController;

@end

@implementation PUDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Turn off any URL caching for security reasons. Keeps any sensitive data from being available to prying eyes.
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0
                                                            diskCapacity:0
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    
    // Enable PI Analytics for our apps for now
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:ETPIAnalyticsActive];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // set status bar style
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // set the overall app tint color
    [[UINavigationBar appearance] setBarTintColor:[UIColor etPrimaryOrange]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    // set page control appearance
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    // uncomment these if you would like to override landing page default colors
    //[[UIToolbar appearanceWhenContainedIn:[ETLandingPagePresenter class], nil] setBarTintColor:[UIColor etPrimaryOrange]];
    //[[UIBarButtonItem appearanceWhenContainedIn:[ETLandingPagePresenter class], nil] setTintColor:[UIColor whiteColor]];
    
    /**
     ET_NOTE: In this sample app, the PUDUtility class is responsible for checking what preprocessor macros are defined (DEBUG, ADHOC, etc) and then returning the correct appId or accessToken. This is a bit more complicated build setup than typical, due to Salesforce needing to support four different build configurations (debug, adhoc, qa, and release). The important thing is to ensure that the AppID and AccessToken you proivde match up to the Code@ET app you wish to send from and have the correct APNS certificates tied to.
     
     If you are unsure of your credentials or need help, please reach out to your Support partner. Likewise, if these services are not active in your account, log statements will be in your console to that effect. Please work with your sales or support rep if you have questions.
     */
    
    /**
     *  The below method has to be implemented ONLY ONCE in the SDK. The below conditions are specifically for this app and you will NOT need multiple/ conditional implementation like this in your own app
     */

    [[ETPush pushManager] configureSDKWithAppID:[PUDUtility appID] // The App ID from Code@ExactTarget
                                 andAccessToken:[PUDUtility accessToken] // The Access Token from Code@ExactTarget
                                  withAnalytics:YES // Whether or not you would like to use Salesforce analytics services
                            andLocationServices:YES  // Whether or not you would like to use location-based alerts
                                  andCloudPages:YES]; // Whether or not you would like to use CloudPages.
    
    /**
     ET_NOTE: The OpenDirect Delegate must be set in order for OpenDirect to work with URL schemes other than http or https. Set this before you call [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
     */
    [[ETPush pushManager] setOpenDirectDelegate:self];
    
    /**
     ET_NOTE: This method delivers the launch options dictionary to the SDK. This is a required implementation step to ensure that pushes are delivered and processed by Salesforce.
     */
    [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
    
    /**
     ET_NOTE: This method begins the push registration workflow. It indicates to iOS (and Apple) that this application wishes to send push messages. It is required for push, but the flags you provide are at your descretion (at least one is required).
     
     UIRemoteNotificationTypeAlert - This flag will ask for permission to show text to the user, in either Banner or an Alert.
     UIRemoteNotificationTypeBadge - This flag allows you to update the badge on the app icon
     UIRemoteNotificationTypeSound - This flag allows you to play a sound when the push is received.

     // Use these for IOS8 instead of UIRemoteNotificationType...
     UIUserNotificationTypeBadge - This flag allows you to update the badge on the app icon
     UIUserNotificationTypeSound - This flag allows you to play a sound when the push is received.
     UIUserNotificationTypeAlert - This flag will ask for permission to show text to the user, in either Banner or an Alert.
     */
    
    // See ETPush.h for reasoning behind this #if logic
    // IPHONEOS_DEPLOYMENT_TARGET = 6.X or 7.X
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    // Supports IOS SDK 8.X (i.e. XCode 6.X and up)
    // are we running on IOS8 and above?
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
        // create user actions here if wanted
        UIMutableUserNotificationAction *userActionButton1 = [[UIMutableUserNotificationAction alloc] init];
        userActionButton1.identifier = @"userActionButton1";
        userActionButton1.title = @"View Offer";
        
        // Given seconds, not minutes, to run in the background
        userActionButton1.activationMode = UIUserNotificationActivationModeBackground;
        userActionButton1.destructive = NO;
        
        // If YES requires passcode, but does not unlock the device
        userActionButton1.authenticationRequired = NO;
        
        UIMutableUserNotificationAction *userActionButton2 = [[UIMutableUserNotificationAction alloc] init];
        userActionButton2.identifier = @"userActionButton2";
        userActionButton2.title = @"Add to Passbook";
        
        // Given seconds, not minutes, to run in the background
        userActionButton2.activationMode = UIUserNotificationActivationModeBackground;
        userActionButton2.destructive = NO;
        
        // If YES requires passcode, but does not unlock the device
        userActionButton2.authenticationRequired = NO;
        
        UIMutableUserNotificationAction *userActionButton3 = [[UIMutableUserNotificationAction alloc] init];
        userActionButton3.identifier = @"userActionButton3";
        userActionButton3.title = @"Snooze";
        
        // Given seconds, not minutes, to run in the background
        userActionButton3.activationMode = UIUserNotificationActivationModeBackground;
        userActionButton3.destructive = NO;
        
        // If YES requires passcode, but does not unlock the device
        userActionButton3.authenticationRequired = NO;
        
        UIMutableUserNotificationAction *userActionButton4 = [[UIMutableUserNotificationAction alloc] init];
        userActionButton4.identifier = @"userActionButton4";
        userActionButton4.title = @"Call Support";
        
        // this one runs in the foreground
        userActionButton4.activationMode = UIUserNotificationActivationModeForeground;
        userActionButton4.destructive = NO;
        
        // If YES requires passcode, but does not unlock the device
        userActionButton4.authenticationRequired = NO;
        
        // create a category to handle the buttons
        UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
        category.identifier = @"Example";
        
        // these will be the default context buttons
        [category setActions:@[userActionButton1, userActionButton2, userActionButton3, userActionButton4] forContext:UIUserNotificationActionContextDefault];
        
        // these will be the minimal context buttons
        [category setActions:@[userActionButton1, userActionButton4] forContext:UIUserNotificationActionContextMinimal];
        
        // make a set of all categories the app will support - just one for now
        NSSet *categories = [NSSet setWithObjects:category, nil];
        
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge |
                                                UIUserNotificationTypeSound |
                                                UIUserNotificationTypeAlert
                                                                                 categories:categories];
        [[ETPush pushManager] registerUserNotificationSettings:settings];
        [[ETPush pushManager] registerForRemoteNotifications];
    }
    else {
        [[ETPush pushManager] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
    }
#else
    // Supports IOS SDKs < 8.X (i.e. XCode 5.X or less)
    [[ETPush pushManager] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
#endif
#else
    // IPHONEOS_DEPLOYMENT_TARGET >= 8.X
    // Supports IOS SDK 8.X (i.e. XCode 6.X and up)
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                            UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert
                                                                             categories:nil];
    [[ETPush pushManager] registerUserNotificationSettings:settings];
    [[ETPush pushManager] registerForRemoteNotifications];
#endif
    
    /**
     ET_NOTE: If you specify YES, then a UIAlertView will be shown if a push received and the app is in the active state. This is not the recommended best practice for production apps but is called for in some use cases
     */
    [[ETPush pushManager] shouldDisplayAlertViewIfPushReceived:NO];
    
    /**
     ET_NOTE: This method is required in order for location messaging to work and the user's location to be processed
     */
    [[ETLocationManager locationManager] startWatchingLocation];
    
    /**
     ET_NOTE: Logging the device id is very useful for debugging purposes. One thing this can help you do is create a filtered list inside of MobilePush that only includes the device that matches this id.
     */
    NSLog(@"== DEVICE ID ==\nThe ExactTarget Device ID is: %@\n", [ETPush safeDeviceIdentifier]);
    
    // To enable logging while debugging
    [ETPush setETLoggerToRequiredState:YES];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    /**
     ET_NOTE: This method resets the application's badge icon to 0, and lets Salesforce know that as well. It is required to clear the badge, and should be called here.
     */
    [[ETPush pushManager] resetBadgeCount];
}

// See ETPush.h for reasoning behind this #if logic
// IPHONEOS_DEPLOYMENT_TARGET = 6.X or 7.X
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 80000
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
// Supports IOS SDK 8.X (i.e. XCode 6.X and up)
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [[ETPush pushManager] didRegisterUserNotificationSettings:notificationSettings];
}

// handle categories for local notifications
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler
{
    if ([identifier isEqualToString:@"userActionButton1"]) {
        [self handleUserAction1WithNotification:notification.userInfo];
    }
    else if ([identifier isEqualToString:@"userActionButton2"]) {
        [self handleUserAction2WithNotification:notification.userInfo];
    }
    else if ([identifier isEqualToString:@"userActionButton3"]) {
        [self handleUserAction3WithNotification:notification.userInfo];
    }
    else if ([identifier isEqualToString:@"userActionButton4"]) {
        [self handleUserAction4WithNotification:notification.userInfo];
    }
    
    completionHandler();
}

// handle categories for remote notifications
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    if ([identifier isEqualToString:@"userActionButton1"]) {
        [self handleUserAction1WithNotification:userInfo];
    }
    else if ([identifier isEqualToString:@"userActionButton2"]) {
        [self handleUserAction2WithNotification:userInfo];
    }
    else if ([identifier isEqualToString:@"userActionButton3"]) {
        [self handleUserAction3WithNotification:userInfo];
    }
    else if ([identifier isEqualToString:@"userActionButton4"]) {
        [self handleUserAction4WithNotification:userInfo];
    }
    
    completionHandler();
}

- (void)handleUserAction1WithNotification:(NSDictionary *)notification
{
    NSLog(@"handleUserAction1WithNotification - %@", notification);
}

- (void)handleUserAction2WithNotification:(NSDictionary *)notification
{
    NSLog(@"handleUserAction2WithNotification - %@", notification);
}

- (void)handleUserAction3WithNotification:(NSDictionary *)notification
{
    NSLog(@"handleUserAction3WithNotification - %@", notification);
}

- (void)handleUserAction4WithNotification:(NSDictionary *)notification
{
    NSLog(@"handleUserAction4WithNotification - %@", notification);
    // call Salesforce main telephone #
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", @"18663624538"]]])
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", @"18663624538"]]];
}
#endif
#else
// IPHONEOS_DEPLOYMENT_TARGET = 8.X
// Supports IOS SDK 8.X (i.e. XCode 6.X and up)
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [[ETPush pushManager] didRegisterUserNotificationSettings:notificationSettings];
}
#endif


/**
 These are the Apple Push Notification Service Delegate methods. They are required for the Push lifecycle to work, and implementation of the Salesforce methods within is required for Salesforce's MobilePush to function as expected. You may copy this block directly to your code and modify it to your liking, or cherry-pick the required methods to your own implementation.
 */
#pragma mark - Push Notification Delegate Calls

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"== TOKEN SUCCESS ==\nReceived a token! It is %@\n", deviceToken);
    
    /**
     ET_NOTE: This method informs the SDK of the received device token. It is required.
     */
    [[ETPush pushManager] registerDeviceToken:deviceToken];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"== TOKEN FAILURE ==\nFailed to receive a token from Apple. Error: %@\n", [error localizedDescription]);
    
    /**
     ET_NOTE: This method lets the SDK know that registration failed. The NSLog statement isn't required, but you are highly encouraged to log this error, because it will help you get back to a working push implementation. It is a required method.
     */
    [[ETPush pushManager] applicationDidFailToRegisterForRemoteNotificationsWithError:error];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"== NON BACKGROUND PUSH ==\nReceived a push: %@\n", userInfo);
    
    /**
     Show an alert view and save the user info in order to be able to show the last received push at a later time
     */
    [self notificationReceivedWithUserInfo:userInfo messageType:kPUDMessageTypeOutbound alertText:nil];
    
    /**
     ET_NOTE: This lets the SDK know that a push was delivered to the app, and passes in the userInfo dictionary so Salesforce can process it and handle tracking opens. It is required.
     */
    [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];
}

/**
 Starting with iOS 7, this method will be called if the app registers for background push notifications in the application's Capabilities section. The implementation within will largely depend on your work, but the ETPush method is required.
 
 ET_NOTE: Note, please, that if you do imeplement this method, the other didRegisterRemoteNotification won't fire.
 */
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"== BACKGROUND PUSH ==\nReceived a background push: %@\n", userInfo);
    
    /**
     Show an alert view and save the user info in order to be able to show the last received push at a later time
     */
    [self notificationReceivedWithUserInfo:userInfo messageType:kPUDMessageTypeOutbound alertText:nil];
    
    /**
     ET_NOTE: This lets the SDK know that a push was delivered to the app, and passes in the userInfo dictionary so Salesforce can process it and handle tracking opens. It is required.
     */
    [[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState]; // Required for ETPush
    
    /**
     ET_NOTE: Your implementation should ultimately call this method based on the discovery of if there was a successful fetch or not. Failure to do so will cause an app crash.
     */
    completionHandler(UIBackgroundFetchResultNewData);
}

/**
 ET_NOTE: This method handles local notifications, which the SDK may fire instead of a remote (push) notification. Implementation of this method is required if you are using Salesforce location-based sending.
 */
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    /**
     Show and alert view and save the user info in order to be able to show the last received push at a later time
     */
    [self notificationReceivedWithUserInfo:notification.userInfo messageType:kPUDMessageTypeLocation alertText:notification.alertBody];
    
    /**
     ET_NOTE: This lets the SDK know that a local notification was received and passes in the notification so Salesforce can process it. It is required for location-based sending.
     */
    [[ETPush pushManager] handleLocalNotification:notification]; // Required for ETPush
}

#pragma mark - OpenDirect delegate implementation

- (BOOL)shouldDeliverOpenDirectMessageIfAppIsRunning {
    /**
     *  ET_NOTE: For this app, the choice was made to not handle the OpenDirect payload immediately if the app is active. This is because the user may be in the middle of an action where displaying a modal view would be too disorienting at the current time
     */
    return NO;
}

- (void)didReceiveOpenDirectMessageWithContents:(NSString *)payload {
    /**
     ET_NOTE: Create the web view controller that will load the link. In your own app you will want to determine the scheme and based on that decide whether or not you need to open up to a specific page inside your app or present a web view like done here. HTTP and HTTPS schemes can be handled by the SDK even when an OpenDirect delegate is not set. For more information consult the OpenDirect documentation at https://exacttarget.github.io/MobilePushSDK-iOS/Protocols/ExactTargetOpenDirectDelegate.html
     */
    [self handleOpenDirectPayload:payload];
}

#pragma mark - Other methods

/**
 *  This method is NOT required in order to implement the SDK. This method is here because we want to display info around the push payload directly inside the app. You will not need to do anything like this inside your app because you will not be displaying the push payload to your app users
 */
- (void)notificationReceivedWithUserInfo:(NSDictionary *)userInfo messageType:(NSString *)messageType alertText:(NSString *)alertText {
    /**
     Save the user info in order to be able to show the last received push at a later time
     */
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:kPUDUserDefaultsLastPushReceivedDate];
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:kPUDUserDefaultsPushUserInfo];
    [[NSUserDefaults standardUserDefaults] setObject:messageType forKey:kPUDUserDefaultsMessageType];
    [[NSUserDefaults standardUserDefaults] setObject:alertText forKey:@"** No Alert Text Available **"];
    
    /**
     *  Location message userInfo dictonaries won't have an alert specified so see if alertText isn't nil. If it is nil, attempt to pull the alert text from the userInfo dictionary
     */
    if (alertText) {
        [[NSUserDefaults standardUserDefaults] setObject:alertText forKey:kPUDUserDefaultsAlertText];
    }
    else {
        NSDictionary *apsDictionary = userInfo[@"aps"];
        if (apsDictionary) {
            alertText = apsDictionary[@"alert"];
            [[NSUserDefaults standardUserDefaults] setObject:alertText forKey:kPUDUserDefaultsAlertText];
        }
    }
    
    /**
     *  Save to user defaults
     */
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *message = [[NSUserDefaults standardUserDefaults] objectForKey:kPUDUserDefaultsAlertText];
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    
    BOOL hasDiscountCodeCustomKey = ([userInfo objectForKey:kPUDMessageDetailCustomKeyDiscountCode] != nil);
    BOOL hasOpenDirectPayload = ([userInfo objectForKey:kPUDPushDefineOpenDirectPayloadKey] != nil);
    BOOL hasCloudPagePayload = ([userInfo objectForKey:kPUDPushDefineCloudPagePayloadKey] != nil);
    BOOL isLocationMessage = ([messageType isEqualToString:kPUDMessageTypeLocation]);
    
    /**
     *  If app is active, show an alert view letting the user know that they received a push message. This can be automatically handled by the SDK if you call the [[ETPush pushManager] shouldDisplayAlertViewIfPushReceived:YES] being sure to pass in YES. Again, note that it is uncommon to do it this way - the SDK's handling of this will most likely suffice for your app
     */
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        if (hasCloudPagePayload) {
            /**
             *  Show an alert view witht the message associated with the cloudpage
             */
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[[UIAlertView alloc] initWithTitle:appName
                                            message:message
                                           delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil] show];
            });
        }
        else if (hasOpenDirectPayload && !isLocationMessage) {
            /**
             *  Show an alert view with the message and the option to view the opendirect. This is done because we don't want to interrupt the user's experience by handling the opendirect unless they willingly choose to view the opendirect
             */
            [[[UIAlertView alloc] initWithTitle:appName
                                        message:message
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:@"View", nil] show];
        }
        else if (hasDiscountCodeCustomKey) {
            /**
             *  Show an alert view with the message and the option to view the discount code. This is done because we don't want to interrupt the user's experience by handling the discount code unless they willingly choose to view the opendirect
             */
            [[[UIAlertView alloc] initWithTitle:appName
                                        message:message
                                       delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:@"View", nil] show];
        }
        else {
            /**
             *  Show an alert view with the message and the OK button
             */
            [[[UIAlertView alloc] initWithTitle:appName
                                        message:message
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        }
    }
    else if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive) {
        /**
         *  We will fall in this condition whenever a user taps a notification from outside the application. For the purposes of this app we will display the discount view if the message doesn't have opendirect. Note that you would handle this case however you want inside of your own app
         */
        if (hasDiscountCodeCustomKey && !hasOpenDirectPayload) {
            [self handleDiscountCodePayload];
        }
    }
    
    // Posting "Push Received Notification" notification to refresh views (PUDMessageReceivedTableViewController)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kPUDPushReceivedNotification"
                                                        object:self
                                                      userInfo:nil];
    
}

/**
 *  This dismisses the web view controller from the view stack
 */
- (void)doneButtonTapped:(UIButton *)sender {
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
        self.webViewController = nil;
        self.discountViewController = nil;
    }];
}

/**
 *  This method is NOT required in order to implement the SDK. This is used specifically for this app and you will likely not need a method like this in your own app
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

    if (buttonIndex != alertView.cancelButtonIndex) {
        /**
         *  Handle the payload immediately because the subscriber clicked the view button
         */
        NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kPUDUserDefaultsPushUserInfo];
        BOOL hasDiscountCodeCustomKey = ([userInfo objectForKey:kPUDMessageDetailCustomKeyDiscountCode] != nil);
        BOOL hasOpenDirectPayload = ([userInfo objectForKey:kPUDPushDefineOpenDirectPayloadKey] != nil);
        
        if (hasOpenDirectPayload) {
            [self handleOpenDirectPayload:[userInfo objectForKey:kPUDPushDefineOpenDirectPayloadKey]];
        }
        else if (hasDiscountCodeCustomKey) {
            [self handleDiscountCodePayload];
        }
    }
}

- (void)handleOpenDirectPayload:(NSString *)payload {
    // dismiss discount view if it is currently being shown
    if (self.discountViewController) {
        [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
            self.webViewController = nil;
            self.discountViewController = nil;
            [self handleOpenDirectPayload:payload];
        }];
        return;
    }
    
    if (self.webViewController) {
        [self.webViewController setURL:[NSURL URLWithString:payload]];
        [self.webViewController load];
    }
    else {
        if (self.window.rootViewController) {
            self.webViewController = [[PBWebViewController alloc] init];
            self.webViewController.navigationItem.title = @"Loading OpenDirect...";
            self.webViewController.URL = [NSURL URLWithString:payload];
            
            PUDNavigationController *navController = [[PUDNavigationController alloc] initWithRootViewController:self.webViewController];
            navController.navigationItem.title = @"Push Received";
            
            self.webViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close\t" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.window.rootViewController presentViewController:navController
                                                             animated:YES
                                                           completion:^{
                                                           }];
            });
        }
    }
}

- (void)handleDiscountCodePayload {
    // dismiss web view if it is currently being shown
    if (self.webViewController) {
        [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
            self.webViewController = nil;
            self.discountViewController = nil;
            [self handleDiscountCodePayload];
        }];
        return;
    }
    
    // handle showing the discount code here
    if (self.discountViewController) {
        [self.discountViewController reloadDiscountData];
    }
    else {
        if (self.window.rootViewController) {
            self.discountViewController = [[UIStoryboard storyboardWithName:kPUDStoryboardMain bundle:nil] instantiateViewControllerWithIdentifier:kPUDStoryboardIdentifierDiscountCodeViewController];
            
            PUDNavigationController *navController = [[PUDNavigationController alloc] initWithRootViewController:self.discountViewController];
            navController.navigationItem.title = @"Push Received";
            
            self.discountViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close\t" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.window.rootViewController presentViewController:navController
                                                             animated:YES
                                                           completion:nil];
            });
        }
    }
}

@end
