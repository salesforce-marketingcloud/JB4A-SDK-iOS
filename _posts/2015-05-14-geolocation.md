---
layout: page
title: "GeoLocation"
subtitle: "Adding GeoLocation"
category: location
date: 2015-05-14 08:43:35
order: 2
---

To implement location services, pass a YES value for the andLocationServices parameter and use ETLocationManager to monitor location and geofence for a user.

~~~
   // configure and set initial settings of the JB4ASDK
    successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Debug
                                              andAccessToken:kETAccessToken_Debug
                                               withAnalytics:NO
                                         andLocationServices:YES
                                               andCloudPages:NO
                                             withPIAnalytics:NO
                                                       error:&error];
        
    [[ETLocationManager locationManager] startWatchingLocation];
~~~ 
<br/>
Make sure you also add the NSLocationAlwaysUsageDescription key to your application's *.plist file. Review the linked documentation for more information: <a href="https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW18" target="_blank">NSLocationAlwaysUsageDescription</a> and <a href="https://developer.apple.com/library/ios/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW27" target="_blank">NSLocationUsageDescription</a>

<br/>
<img class="img-responsive" src="{{ site.baseurl }}/assets/plist_locationservices_step1.png" /><br/>