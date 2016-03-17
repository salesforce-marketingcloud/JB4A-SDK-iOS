---
layout: page
title: "GeoLocation"
subtitle: "Adding GeoLocation"
category: location
date: 2015-05-14 08:43:35
order: 2
---

To implement location services, pass a YES value for the andLocationServices parameter and use ETLocationManager to monitor location and geofence for a user.

<script src="https://gist.github.com/sfmc-mobilepushsdk/97f89bf21b6dd92929b1.js"></script>

After calling configureSDK(), you must make the following call to initiate location services within the SDK.  This call will also ensure your customer is given the opportunity to accept or deny location services within your app.

You do not have to call this from didFinishLaunchingWithOptions() if you prefer to notify the user about using location in another view.  However, it is recommended to request this information as soon as possible.  When making this call for the first time, iOS will prompt the user for permission to access location services.

<script src="https://gist.github.com/sfmc-mobilepushsdk/092adf7e911614c30daf.js"></script>

Ensure you also add the NSLocationAlwaysUsageDescription key to the *.plist file for your application. Review Apple documentation for more information: <a href="https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW18" target="_blank">NSLocationAlwaysUsageDescription</a>.

<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/location_usage_plist_entry.png" /><br/>

> iOS 8+ builds must used NSLocationAlwaysUsageDescription key for location to work.  The previous named key of NSLocationUsageDescription will not work in ios8+ builds.  If you have both, then the new key NSLocationAlwaysUsageDescription wins and the old key NSLocationUsageDescription will be ignored.  

Implement the following keys if you wish to enable this functionality:

* "App downloads content from the network" is required to perform a Background App Refresh periodically to refresh geofences and beacons.
* "App registers for location updates" is required if you have Proximity Services turned on in configureSDK and want to range for beacons in the background (only for Beacon Beta Testers)

	<br/><img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>
