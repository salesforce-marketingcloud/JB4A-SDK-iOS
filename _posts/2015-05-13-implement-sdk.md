---
layout: page
title: "Download and Implement SDK"
subtitle: "Download and Implement SDK in your iOS App"
category: get-started
date: 2015-05-14 12:00:00
order: 3
---
Download the [JB4A SDK]({{site.codeurl}}) for your mobile app, then complete these steps to configure the SDK for your app. Once you complete this process and run your first test, the SDK connects the device to the MobilePush app you created in the [App Center]({{ site.baseurl }}/get-started/create-apps-overview.html).<br/><br/>

<h4>Import the SDK</h4>
Use one of these two ways to import the SDK for iOS into your project:

1.	[CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)
1.	Static Library

Only use one of these two ways to import the SDK - not both.

> Do not use the JB4A-SDK-iOS podspec. Use the [JB4A SDK podspec](https://cocoapods.org/?q=jb4a) instead.

<h4>Configure the SDK with CocoaPods</h4>

Follow the [CocoaPods installation instructions](https://guides.cocoapods.org/using/using-cocoapods.html) using **JB4ASDK** as a dependency in the podfile. Open up the *.xcworkspace created by the install process with Xcode and start using the SDK.

> Do <b>NOT</b> use *.xcodeproj. If you open up a project file instead of a workspace, you will receive an error.<br/>

<h4>Configure the SDK with header files and static library</h4>

Follow these steps to configure the SDK for your app.<br/>

1.  In your app development environment, copy the libJB4ASDK-*.a and the header files into your project.
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/iossdk-artifacts.png" /><br/>
<br/>
1.  Select **Project Settings**.

1.  Select **General**.

1.  Add libJB4ASDK-*.a to Linked Frameworks and Libraries in the Build Phases configuration section within Xcode.

1.	Include the WebKit.framework in Link Binary With Libraries section of the Build Phases configuration in Xcode.

#### Configure the SDK

> Threading caution - The JB4ASDK is not thread-safe. We do not recommend mixing API calls to the SDK on different threads. Make all calls to the SDK API on the same thread. You can call the SDK from the main thread or from a background thread, but make all calls to the SDK on the same thread.

1. Add code in the AppDelegate implementation class to configure the Journey Builder for Apps SDK. Note that you must call configureSDKWithAppId and andAccessToken and provide values from the app you created in MobilePush.
	<script src="https://gist.github.com/sfmc-mobilepushsdk/076015adff482663719373704f60925b.js"></script>
A call to resetBadgeCount includes a call to updateET, which sends a registration with a badge count value of zero. Registrations are processed every few minutes in batch. You can keep the device and the device record in sync if you only send notifications with badge updates once every 10 minutes.

1.	In **App Settings**, set the **Push Notifications** switch to **ON**.
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/pushNotifications.png" /><br/>
<br/>

	Note that calling didReceiveLocalNotification on an app in the foreground of a mobile device will display a notification in the Apple Notification Center, but the mobile device will not provide a visibile or audible notification. Use an AlertController to display a message regarding the new notification. If you choose to display an alert, ensure that you clear the Apple Notification Center upon display of the alert.

	You can also call didReceiveRemoveNotification for an active app in the foreground of a mobile device. In this case, the app will not display an alert in the Apple Notification Center or provide a visible or audible notification. Decide whether to display an alert to the user upon receipt of the notification in this case.

1.  Determine whether you need to implement any of the following keys to your applications plist file:

	* "App downloads content from the network" is required to perform a Background App Refresh periodically for [regions and messages]({{ site.baseurl }}/location/geolocation.html#plist).
	* "App registers for location updates" is required if you have Proximity Services turned on in `configureSDKWithAppID` and you want to [range for beacons]({{ site.baseurl }}/features/features-logging.html#plist) in the background.
	* "App downloads content in response to push notifications" is required if you plan on using [silent push]({{ site.baseurl }}/features/background-push.html) notifications.

	<br/><img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>

You can now deploy and test your app!

> You can use an iOS simulator for testing, but the simulator will not receive push messages as part of the testing process.

<h4>Getting Started with Swift</h4>
Create an Objective-C bridging header file using Xcode. Ensure you copy the contents of JB4ASDK-Bridging-Header.h into your bridging header. You can also use the provided bridging header JB4ASDK-Bridging-Header.h as a starting point.

From Objective-C Bridging Header (under Build Settings in Your Target), point Objective-C Bridging Header to the bridging header you just created.<br/><br/>

#### Track Push Notifications

To ensure that push notifications are properly tracked by the SDK and Marketing Cloud analytics, you must call `[[ETPush pushManager] handleNotification:userInfo forApplicationState:application.applicationState];` like this:
<script src="https://gist.github.com/sfmc-mobilepushsdk/302c876fb8e4cf6d7b7eb0fa65bcaa79.js"></script>

If you don't, analytic events can't track open counts for your push messaging campaigns.
