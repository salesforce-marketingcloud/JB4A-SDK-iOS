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

#### <a name="plist-updates"></a>plist Updates

There are two plist entries you can make depending on how current you want to keep your Location regions and messages.  

1.  Background App Refresh - Normally, new regions and messages are downloaded as the device moves more than 5k from their last location (and download).  However, if you have an app where your customers spend a lot of time within a single 5K radius, you should consider adding the ability to do a background refresh of geofences and messages.  Since Apple controls when this background refresh takes place, there isn't a guarantee when the refresh will occur.  However, it will allow the SDK to download new regions and messages for those times your customer is spending a considerable amount of time in a single 5K region.

2.  Range for Beacons in the background - This permission will ensure that your app will be able to range for Beacons when your app is in the background or suspended.  Note that this is required **only** if you are part of the Beacon Beta testing group.

Implement the following keys if you wish to enable either of these two functions:

* "App downloads content from the network" is required to perform a Background App Refresh periodically to refresh geofences and beacons.
* "App registers for location updates" is required if you have Proximity Services turned on in configureSDK and want to range for beacons in the background (only for Beacon Beta Testers)

<br/><img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>
