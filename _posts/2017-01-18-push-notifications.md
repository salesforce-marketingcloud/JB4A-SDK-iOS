---
layout: page
title: "Push Notifications"
subtitle: "Implementing Push Notification Support"
category: sdk-interfaces
date: 2017-01-18 12:00:00
order: 3.0
---

Note: iOS 9 notifications are still supported.

## Push Notification Registration
iOS 10 offers a more consistent and powerful way to use notifications, which are implemented in UserNotification.framework. The MarketingCloudSDK natively supports UserNotification.framework functionality through MarketingCloudSDK interfaces. MarketingCloudSDK offers a simple wrapper around common interfaces of UNUserNotificationCenter, adding logging and error checking on behalf of the application using the SDK.

To use UserNotification.framework in applications that target iOS 10:

- Build your app with XCode 8 and the iOS 10 SDK
- Add UserNotification.framework to the Link Binary With Libraries section of your app target’s Build Phases
- Register your app for notifications using the UserNotification registration method. Do not use older registration methods in UIApplication. The UserNotification registration method allows you to support features such as notification service extensions, foreground push notification display, mutable content, etc.
- Contact your account executive to to enable rich notifications (mutable content) for your app.


Use the following method to enable iOS 10 notifications. When this method is called by an application (in `-application:didFinishLaunchingWithOptions:`, for example), it sets the application for full compatibility with iOS 10 notification handling.


`(void)sfmc_registerForRemoteNotificationsWithDelegate:(_Nullable id<UNUserNotificationCenterDelegate>) delegate options:(UNAuthorizationOptions)options categories:(NSSet<UNNotificationCategory *> *_Nullable)categories completionHandler:(void (^)(BOOL granted, NSError *_Nullable error))completionHandler`

The method can be called like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/5bd93878bc6225478a0261fcaeae5e13.js"></script>

Parameters: delegate – Assign the delegate before your app is done launching. For details, see [Apple’s API Reference](https://developer.apple.com/reference/usernotifications/unusernotificationcenterdelegate).

If necessary, MarketingCloudSDK’s `-sfmc_setUserNotificationCenterDelegate:` can be called early in the app lifecycle and later in registration to satisfy the conditions described by Apple.
You can set delegate to nil for default notification handling. If a delegate is passed, you must ensure that the delegate class adheres to the UNUserNotificationCenterDelegate protocol, like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/e18cc9036e92ca08ae75d461c5eca287.js"></script>

## Handling Notification Registration

An application delegate must implement UIApplication delegate methods to handle registration success and failure cases. At a minimum, implement these methods like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/45df2f63abc79bd8c93b2d6e88868dfe.js"></script>

If your application supports iOS 9 in addition to iOS 10, your notification registration code must make a runtime check for iOS version and call the appropriate registration method, like this example:

<script src="https://gist.github.com/sfmc-mobilepushsdk/24652b4c0ab436649f832eb569cd0c4e.js"></script>

## Convenience Methods
MarketingCloudSDK implements a number of methods that act as pass-throughs to the UNUserNotificationCenter methods. These convenience methods allow MarketingCloudSDK to perform additional logging and error checking. You can consider these as analogues to the method in UNUserNotificationCenter. See `MarketingCloudSDK+Notifications.h for more information.

## Delegate Methods
When running on iOS10, the following two methods of the UNUserNotificationCenterDelegate protocol are required in order to process notifications. You must set the delegate property of your UNNotificationCenter instance to the class that implements them. Do this either by setting the delegate in the `-sfmc_registerForRemoteNotificationsWithDelegate:options:categories:completionHandler:` call as shown above or by calling `-[[MarketingCloudSDK sfmcSDK] sfmc_setUserNotificationCenterDelegate:]`. The delegate must be set before the application returns from `-application:didFinishLaunchingWithOptions:`.

The first method, didReceiveNotificationResponse, is called to let your app know which action the user selected for a given notification. The second method, willPresentNotification, is called when a notification is delivered to a foregrounded app. The examples below show how to pass the notification to MarketingCloudSDK in order for the SDK to process the notification properly.

<script src="https://gist.github.com/sfmc-mobilepushsdk/f993c9c5e8775de7b84b1998e764e8a3.js"></script>
