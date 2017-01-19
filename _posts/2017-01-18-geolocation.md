---
layout: page
title: "GeoLocation"
subtitle: "Adding GeoLocation"
category: location
date: 2017-01-18 08:43:35
order: 2
---

## Using Location
Note: If you create your own core location object, we cannot guarantee that features of our SDK will work as intended. If all that is needed is a location fix, you can access our CLLocationDelegate by calling 

`[[MarketingCloudSDK] sfmcSDK] sfmc_lastKnownLocation]`.

To implement location services, pass a YES value for the `locationServicesEnabled` of `sfmc_configureSDK...`.

<script src="https://gist.github.com/sfmc-mobilepushsdk/3d9dad542bc2766de44c0a5b9739318b.js"></script>

After calling `sfmc_configureSDK...`, you must make the following call to initiate location services within the SDK. This call will also ensure your customer is given the opportunity to accept or deny location services within your app.

You do not have to call this from didFinishLaunchingWithOptions() if you prefer to notify the user about using location in another view. However, it is recommended to request this information as soon as possible. When making this call for the first time, iOS will prompt the user for permission to access location services.

<script src="https://gist.github.com/sfmc-mobilepushsdk/6a800ec89cdcbdf43d4c5bb9ae5d7606.js"></script>

Ensure you also add the NSLocationAlwaysUsageDescription key to the *.plist file for your application. Review Apple documentation for more information: [NSLocationAlwaysUsageDescription](https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW18).

Applications using MarketingCloudSDK must NSLocationAlwaysUsageDescription key for location to work.

<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/location_usage_plist_entry.png" /><br/>


## Info.plist Updates

There is one Info.plist entry to add, depending on the way your app works:

- Background App Refresh - Normally, new regions and messages are downloaded as the device moves more than 5K (5 kilometers) from their last location and download of this data. However, if you have an app where your customers spend a lot of time within a single 5K radius, you should consider adding the ability to do a background refresh of regions and messages. Since Apple controls when this background refresh takes place, there isn’t a guarantee when the refresh will occur. However, it will allow the SDK to download new regions and messages for those times your customer is spending a considerable amount of time in a single 5K region.

- When this Info.plist entry is added, you also need to add code after `smfc_configureSDK...` in the `application:didFinishLaunchingWithOptions:` method of your application delegate to specify the interval for the device to fetch new updates. We recommend `UIApplicationBackgroundFetchIntervalMinimum`.

Implement:

<script src="https://gist.github.com/sfmc-mobilepushsdk/64741e4ed697a98244e2518245b26c76.js"></script>

The handler that will be called to complete this background refresh is added to the AppDelegate.m file:

<script src="https://gist.github.com/sfmc-mobilepushsdk/2466d26800492b636fd8faa9515c0269.js"></script>

Implement the following key if you want to enable this function:

- “App downloads content from the network” is required to perform a Background App Refresh periodically to refresh geofences and beacons.

<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/background_modes_plist_entry.png" /><br/>

MobilePush prevents the app from displaying a geofence message with an empty alert. If you include AMPscript in your message that returns no content or an empty string, the mobile app will not display that message.

For more information, see `MarketingCloudSDK+Location.h`.