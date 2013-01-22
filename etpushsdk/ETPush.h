//
//  etpushsdk.h
//  etpushsdk
//
//  Created by Eddie Roger on 9/7/12.
//  Copyright (c) 2012 ExactTarget, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ETData.h"
#import "ETDataconnector.h"
#import "PushConstants.h"

/** 
 This is the main interface to the ExactTarget MobilePush SDK. It is meant to handle a lot of the heavy lifting with regards to sending data back to ExactTarget. 
 
 Please note that this is a singleton object, and you should reference it as [ETPush pushManager].
 */
@interface ETPush : NSObject
{
    NSDateFormatter *_commonDateFormatter;
    NSDate *_sessionStart;
    NSString *_messageID;
    
    ETPushMode _pushMode;
    BOOL _showLocalAlert;
}

/**---------------------------------------------------------------------------------------
 * @name Configuring the app for ETPush
 *  ---------------------------------------------------------------------------------------
 */

/**
 Returns (or initializes) the shared pushManager instance.
 
 @return The singleton instance of an ETPush pushManager.
 */
+(ETPush *)pushManager;
-(id)init;

/**
 This is the main configuration method, responsible for adding credentials necessary to the SDK for basic functionality to work. 
 
 If you are unsure of any of these variables, please check with code@exacttarget (code.exacttarget.com).
 
 @param etAppID The GUID-style ID for your app as set up in Code@
 @param clientID Assigned ID for use with OAuth authentication flow
 @param clientSecret Assigned secret for use with OAuth authentication flow
 @return Doesn't return a value.
 */
-(void)configureSDKWithAppID:(NSString *)etAppID
                       andClientID:(NSString *)clientID
                   andClientSecret:(NSString *)clientSecret;

/**
 Triggers a data send to ExactTarget. Mostly used internally, but this method can be used to prompt a send if you desire. 
 
 */
-(void)updateET;

/**
 Clears the Fuel Auth token data from NSUserDefaults. This isn't always going to be useful, but it is if you do something like change your credentials. Call it with care. 
 
 @return Doesn't return a value.
 */
-(void)clearSavedAuthToken;

/**---------------------------------------------------------------------------------------
 * @name Push Lifecycle
 *
 * These methods are required to make push function on iOS, and to enable the ET SDK to utilize it. All of these methods are required.
 *  ---------------------------------------------------------------------------------------
 */

/**
 Wrapper for iOS' application:registerForRemoteNotifications; call. It will check that push is allowed, and if so, register with Apple for a token. If push is not enabled, it will notify ExactTarget that push is disabled. 
 
 @param types The UIRemoteNotificationTypes that the application would like to use for push. These are pipe-delimited, and use Apple's native values
 */
-(void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types;

/** 
 Responsible for sending a received token back to ExactTarget. It marks the end of the token registration flow. If it is unable to reach ET server, it will save the token and try again later. 
 
 This method is necessary to implementation of ET Push.
 
 @param deviceToken Token as received from Apple, still an NSData object
 @return Doesn't return a value
 */
-(void)registerDeviceToken:(NSData *)deviceToken;

/**
 Handles a registration failure. 
 
 @param error The error returned to the application on a registration failure
 @return Doesn't return a value
 */
-(void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

/**
 Reset the application's badge number to zero (aka, remove it) and let the push servers know that it should zero the count.
 
 @return Doesn't return a value
 */
-(void)resetBadgeCount;

/**
 Tell the SDK to display a UIAlertView if a push is received while the app is already running. Default behavior is set to NO.
 
 Please note that all push notifications received by the application will be processed, but iOS will *not* present an alert to the user if the app is running when the alert is received. If you set this value to true (YES), then the SDK will generate and present the alert for you. It will not play a sound, though.
 
 @param desiredState YES/NO if you want to display an alert view while the app is running. 
 @return Doesn't return a value
 */
-(void)shouldDisplayAlertViewIfPushReceived:(BOOL)desiredState;



/**---------------------------------------------------------------------------------------
 * @name Application Lifecycle
 *
 * These methods are not necessary for the Push lifecycle, but are required to make the ET Push SDK perform as expected
 *  ---------------------------------------------------------------------------------------
 */

/**
 Notifies the ET SDK of an app launch, including the dictionary sent to the app by iOS. The launchOptions dictionary is necessary because it will include the APNS dictionary, necessary for processing opens and other analytic information. 
 
 @param launchOptions The dictionary passed to the application by iOS on launch.
 @return Doesn't return a value
 */
-(void)applicationLaunchedWithOptions:(NSDictionary *)launchOptions;

/**
 Notifies the ET SDK of an app termination. Internally, this method does a lot of cleanup. 
 
 @return Doesn't return a value (but how could it - the app terminated)
 */
-(void)applicationTerminated;

/**
 Handles a push notification received by the app when the application is already running. 
 
 This method must be implemented in [[UIApplication sharedApplication] didReceiveRemoteNotification:userInfo].
 
 Sometimes, when a push comes in, the application will already be running (it happens). This method rises to the occasion of handing that notification, displaying an Alert (if the SDK is configured to do so), and calling all of the analytic methods that wouldn't be called otherwise. 
 
 @param userInfo The dictionary containing the push notification
 @param applicationState State of the application at time of notification
 @return Doesn't return a value.
 */
-(void)handleNotification:(NSDictionary *)userInfo forApplicationState:(UIApplicationState)applicationState;


/**---------------------------------------------------------------------------------------
 * @name Data Interaction
 *  ---------------------------------------------------------------------------------------
 */

/**
 Accepts the email address to identify the device's user.
 */
-(void)setUserEmailAddress:(NSString *)emailAddress;

/**
 Adds the provided Tag (NSString) to the list of tags.
 
 @param tag A string to add to the list of tags
 */
-(void)addTag:(NSString *)tag;

/**
 Removes the provided Tag (NSString) from the list of tags.
 
 @param tag A string to remove from the list of tags
 */
-(void)removeTag:(NSString *)tag;

/**
 Returns the list of tags for this device.
 
 @return All tags associated.
 */
-(NSSet *)allTags;

/**
 Adds an attribute to the data set sent to ExactTarget.
 
 @param name The name of the attribute you wish to send. This will be the key of the pair.
 @param value The value to set for thid data pair.
 */
- (void)addAttributeNamed:(NSString*)name value:(NSString*)value;

/**
 Removes the provided attributef rom the data set to send to ExactTarget.
 
 @param name The name of the attribute you wish to remove. 
 @return Returns the value that was set. It will no longer be sent back to ExactTarget.
 */
- (NSString*)removeAttributeNamed:(NSString*)name;

/**
 Sets the quiet time for the user, where they do not wish to be disturbed. 
 
 The time should be in 24 hour format, and will be treated as local time to the device.
 
 @param start The time to begin quiet time in the format of HH:MM
 @param end The time to end quiet time in the format of HH:MM
 */
- (void)setQuietTimeStart:(NSString*)start end:(NSString*)end;



/**
 @name Listeners for UIApplication events
 */

/**
 Sets up the listeners.
 */
-(void)startListeningForApplicationNotifications;

/**
 Drops the listeners.
 */
-(void)stopListeningForApplicationNotifications;

/**
 Responds to the UIApplicationDidBecomeActiveNotification notification
 */
-(void)applicationDidBecomeActiveNotificationReceived; // UIApplicationDidBecomeActiveNotification

/**
 Responds to the UIApplicationDidEnterBackgroundNotification notification
 */
-(void)applicationDidEnterBackgroundNotificationReceived; // UIApplicationDidEnterBackgroundNotification

-(void)setSdkModeTo:(ETPushMode)newPushMode;
-(ETPushMode)pushMode;


@end
