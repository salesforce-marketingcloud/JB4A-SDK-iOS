---
layout: page
title: "Implement SDK"
subtitle: "Implement SDK in your iOS App"
category: sdk-implementation
date: 2015-05-14 12:00:00
order: 1
---
In order to use the SDK in your Mobile app, complete the steps required to register a device with the Salesforce Marketing Cloud. This process ultimately connects the device to the MobilePush app you created in the [App Center]({{ site.baseurl }}/create-apps/create-apps-overview.html).

1.  In your app development environment, copy the libJB4ASDK-*.a and the header files into your project.
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/iossdk-artifacts.png" /><br/>
<br/>
1.  Select **Project Settings**. 

1.  Select **General**.

1.  Add libJB4ASDK-*.a to Linked Frameworks and Libraries in the Build Phases configuration section within Xcode.

1.  Add code in the AppDelegate implementation class to bootstrap the Journey Builder for Apps SDK. Note that you must call configureSDKWithAppId and andAccessToken and provide values from the Salesforce Marketing Cloud app you created in <a href="https://https://appcenter-auth.s1.marketingcloudapps.com/" target="_blank">App Center<a/>.

	<script src="https://gist.github.com/sfmc-mobilepushsdk/346819617929db86b842.js"></script>

1.  Determine whether you need to implement any of the following keys to your applications plist file:

	* "App downloads content from the network" is required to perform a Background App Refresh periodically to refresh geofences and beacons.
	* "App registers for location updates" is required if you have Proximity Services turned on in configureSDK and want to range for beacons in the background
	* "App downloads content in response to push notifications" is required if you plan on using silent push notifications.

	<img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>

You can now deploy and start your app on a physical test device. You can use an iOS simulator for testing, but the simulator will not receive push messages as part of the testing process.

Once you complete this process, you can build your application and send it push notifications from your Marketing Cloud account.