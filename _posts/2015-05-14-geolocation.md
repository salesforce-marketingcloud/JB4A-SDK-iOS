---
layout: page
title: "GeoLocation"
subtitle: "Adding GeoLocation"
category: location
date: 2015-05-14 08:43:35
order: 2
---

> If you create your own core location object, we cannot guarantee that features of our SDK will work as intended. If all that is needed is a location fix, you can access our CLLocationDelegate by calling [ETLocationManager sharedInstance].

To implement location services, pass a YES value for the andLocationServices parameter and use sharedInstance to monitor location and geofence for a user.

<script src="https://gist.github.com/sfmc-mobilepushsdk/be782b1c6b47fc7db9f911eb9e108eac.js"></script>

After calling configureSDK(), you must make the following call to initiate location services within the SDK.  This call will also ensure your customer is given the opportunity to accept or deny location services within your app.

You do not have to call this from didFinishLaunchingWithOptions() if you prefer to notify the user about using location in another view.  However, it is recommended to request this information as soon as possible.  When making this call for the first time, iOS will prompt the user for permission to access location services.

<script src="https://gist.github.com/sfmc-mobilepushsdk/092adf7e911614c30daf.js"></script>

## Location Messaging

In addition, Apple requires adding keys to your Info.plist file to enable location services:

* NSLocationAlwaysUsageDescription
* NSLocationAlwaysAndWhenInUseUsageDescription
* NSLocationWhenInUseUsageDescription

Review the [Apple documentation](https://developer.apple.com/documentation/corelocation/choosing_the_authorization_level_for_location_services) for more information.

<img class="img-responsive" src="{{ site.baseurl }}/assets/location.png" /><br/>

> MarketingCloudSDK requires “Always” permissions for full geofence and beacon functionality. An application does not receive location messages if “When-in-use authorization” is selected by the app user.

<br/>


#### <a name="plist"></a>Info.plist Updates

There is one Info.plist entry to add, depending on the way your app works:  

* Background App Refresh - Normally, new regions and messages are downloaded as the device moves more than 5K (5 kilometers) from their last location and download of this data.  However, if you have an app where your customers spend a lot of time within a single 5K radius, you should consider adding the ability to do a background refresh of regions and messages.  Since Apple controls when this background refresh takes place, there isn't a guarantee when the refresh will occur.  However, it will allow the SDK to download new regions and messages for those times your customer is spending a considerable amount of time in a single 5K region.

	When this Info.plist entry is added, you also need to add code after `configureSDKWithAppId` in the `didFinishLaunchingWithOptions` method of your **AppDelegate.m** file to specify the interval for the device to fetch new updates.  We recommend `UIApplicationBackgroundFetchIntervalMinimum`:
	<script src="https://gist.github.com/sfmc-mobilepushsdk/9de3a7dddb4641a33e9a.js"></script>

	The handler that will be called to complete this background refresh is added to the **AppDelegate.m** file:
	<script src="https://gist.github.com/sfmc-mobilepushsdk/62b7e5d5c518d4e1f688.js"></script>

Implement the following key if you want to enable this function:

* "App downloads content from the network" is required to perform a Background App Refresh periodically to refresh geofences and beacons.

<br/><img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>

> MobilePush prevents the app from displaying a geofence message with an empty alert. If you include AMPscript in your message that returns no content or an empty string, the mobile app will not display that message. 
