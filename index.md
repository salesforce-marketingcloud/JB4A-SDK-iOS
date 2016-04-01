---
layout: default
title: "README"
---
# Journey Builder for Apps iOS SDK

This documentation includes information for the Marketing Cloud Journey Builder for Apps iOS SDK:<br/>
<a href="https://github.com/ExactTarget/JB4A-SDK-iOS" target="_blank">JB4A iOS SDK GitHub Repository</a><br>

Review the Apple docs for the SDK:<br/>
<a href="{{ site.baseurl }}/appledoc/index.html" target="_blank">iOS SDK Apple Docs</a>

## iOS Version

Use the JB4A iOS SDK with iOS versions 7 or later.

## Release History

For releases prior to v4.2.0, see: <a href="http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS-v4.1.0/" target="_blank">Prior Release Documentation</a>

#### Version 4.2.0
_Released March 21 2016, correlating to the Marketing Cloud 2016-02 Release_<br/>

* MOBILESDK-063 - Fix Geofence and Beacon analytics for region entry, exit, and message displayed.
* MOBILESDK-258 - Improvements to beacon detection and message display.    
* MOBILESDK-268 - Package registration data updates with each update method (such as setTag(), addAttribute()) by
                  issuing REST call 1 minute after first call.  If REST call fails, retry in background until REST 
                  call succeeds or app is suspended.
* MOBILESDK-375 - Update the default landing page used to display OpenDirect and CloudPage+Alert URLs when these notifications are tapped, to use WKWebView rather than UIWebview.   
* MOBILESDK-376 - Set CLLocationManager allowsBackgroundLocationUpdates to YES for iOS9 builds (required for Beacons support).
* MOBILESDK-387 - Improve downloading of new Geofences and Beacons.  New [plist entry]({{ site.baseurl }}/location/geolocation.html#plist) if you would like a daily refresh of regions and messages.
* MOBILESDK-389 - Ensure SQL DB is constrained to at most 1000 rows of Marketing Cloud Analytics.
* MOBILESDK-413 - Make sure device ranges for locations after device reboot.
* MOBILESDK-417 - Add boolean in [configureSDK()]({{ site.baseurl }}/sdk-implementation/implement-sdk.html) to turn on Beacon ranging (if you are part of the Beacon Beta Test).
* MOBILESDK-481 - Attribute names that conflict with Contact record attribute names will be rejected.  Check returned boolean if attribute is accepted.
* MOBILESDK-509 - Reject subscriberKey, Tags and attributes that are null.  Trim leading and trailing blanks before sending.  Blank subscriberKey and Tags will also be rejected.
                  Check returned boolean to determine if the values were accepted.
* MOBILESDK-550 - Fix open and time in app sent for Marketing Cloud analytics.
* MOBILESDK-580 - Implement [getSDKState()]({{ site.baseurl }}/trouble/ios-debugging.html) method to return a JSON string with key SDK values for debugging purposes.
* MOBILESDK-616 - Make the device id persistent across app installs.
* MOBILESDK-634 - Add custom [logging handler]({{ site.baseurl }}/features/features-logging.html).
* MOBILESDK-674 - Add getTags() and getAttributes() and deprecate allTags() and allAttributes().                     
* MOBILESDK-727 - Change [updateET()](http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/appledoc/Classes/ETPush.html#//api/name/updateET) so that it sends Registration data immediately on the first call (after app enters
                  foreground state) and in 1 minute intervals for subsequent calls.

#### Version 4.1.0
_Released February 2, 2016, correlating to the Marketing Cloud 2016-01 Release_<br/>

* MOBILESDK-502 - Create an ETAnalytics class to have parity with Android.
* MOBILESDK-493 - Swift unable to resolve LocationManager.
* MOBILESDK-492 - Library has possible issues with debug symbols.
* MOBILESDK-474 - Registration Opt-In Process incorrectly sends TRUE.
* MOBILESDK-444 - Add Retry logic - iOS.
* MOBILESDK-269 - Make end point configurable for WAMA in SDK.
* MOBILESDK-231 - Add constraints to WAMA Analytics.
* MOBILESDK-217 - Update Analytics

#### Version 4.0.3
_Released November 4, 2015, correlating to the Marketing Cloud 2015-06.HF Release_<br/>

* MOBILESDK-439 - iOS SDK returning latitude/longitude with commas instead of decimal points for certain locales.
* MOBILESDK-428 - Database corruption following VACUUM
* MOBILESDK-427 - Fix for ETEvent analytics to handle Array of dictionaries.

#### Version 4.0.2
_Released October 2, 2015, correlating to the Marketing Cloud 2015-06 Release_<br/>

* MOBILESDK-327 - Fix for missing keychain item when applications are restored from an unencrypted backup.
* MOBILESDK-326 - Only send registration data if different from the last one sent
* MOBILESDK-311 - Application crashing in iOS SDK
* MOBILESDK-310 - Reduce Location REST call traffic to Marketing Cloud
* MOBILESDK-300 - Application crashing in iOS SDK

> This version of the JB4A SDK introduces iOS Keychain usage. To ensure that your app retains any relevant data across user backups and restores, encourage your app users to implement encrypted backups for their devices. Otherwise, information (such as tags, attributes, and subscriber keys) will not persist.

#### Version 4.0.1
_Released July 23rd, 2015_<br/>

* MPUSH-3856 - SUPPORT - Upgrade to MobilePush iOS SDK 4.0.0 from SDK 3.4.2 Causes App to Freeze<br/> 

#### Version 4.0.0
_Released June 24th, 2015, correlating to the Marketing Cloud 2015-04 Release_<br/>

* MPUSH-3605 - SDK iOS: Modify payload to always send english datetime<br/>
* MPUSH-3472 - Change iOS location_enabled registration field to user location opt-in status<br/>
* MPUSH-3442 - Remove Access Token from REST Route Body - iOS<br/>
* MPUSH-3885 - iOS app crashes after viewing Cloud Page Inbox<br/>
* MPUSH-3341 - SDK Updates & Changes<br/>
* MPUSH-3259 - iOS: Encrypt data on device<br/>
* MPUSH-3717 - Timing issue with ExactTargetEnhancedPushDataSource<br/>
* MPUSH-3713 - Added ability to utilize unicode characters in Rich Push subject lines<br/>

**Required Coding Changes** 

The following are changes that must be made in order to upgrade from previous releases of the SDK:<br/><br/>
The latest configureSDKWithAppID has some additional parameters and can be found at [Implement the SDK]({{ site.baseurl }}/sdk-implementation/implement-sdk.html).

You will need to update your configSDK registration call to now read: 

<script src="https://gist.github.com/sfmc-mobilepushsdk/71cf71032cfe92c06d76bf5f894cb115.js"></script>

<!--**Recommended Coding Changes** -->

___

#### Version 3.4.2 ####
_Released March 9, 2015, correlating to Marketing Cloud 2015-02 Release_

* Fix beacon payload message handling for personalized messages
 Added initial PI Analytics - off by default in the SDK
 Enabled IOS Data Protection on SQLite DB. Using NSFileProtectionCompleteUnlessOpen. User must set a passcode to enable.
 Disabled caching of URL responses

___

#### Version 3.4.1 #### 
_Released December 11, 2014_

 * HF.1 - fixed analytics rest route.

___

#### Version 3.4.0 ####
_Released November 17, 2014, correlating to Marketing Cloud 2014-08 Release_

* MPUSH-2753 - Fix for someone calling registerForRemoteNotificationTypes on an IOS8 device. We will transform the call to into the IOS8 call/pair registerUserNotificationSettings and registerForRemoteNotifications using the same alert types (i.e. sound, badges, alerts). This is so push registration will work if the customer doesn't change their code at all and just recompiles with Xcode6 but they want to run on an IOS8 device.<br/>
Calling registerForRemoteNotificationTypes while running on an IOS8 device will fail and you will not get a push token.<br/>
* MPUSH-2752 - Rename PracticeField app to JB4A SDK Explorer (iOS).<br/>
* MPUSH-2855 - Geofence Messages not always displaying when expected.<br/>
* MPUSH-2854 - iOS Beacons not working.<br/>
* MPUSH-3010 - Payload for iOS Local Messages.<br/>

___

#### Version 3.3.0 #####
_Released August 25, 2014, correlating to ExactTarget's 2014-06 Release_<br/>

* MPUSH-2560 - Continued Beacon work to meet further requirements.<br/>
* MPUSH-2488 - Added device locale to registrations.<br/>
* MPUSH-2472 - Introduced ETEvent to track statistics and such going forward. This also includes the addition of the Bulk Uploader Shim and related functionality.<br/>
* MPUSH-2513 - Added the ability to retrieve inactive fences from the SDK's cache. This was previously impossible.<br/>
* MPUSH-2536 - ETLog can now be turned on or off in production. It defaults to off.<br/>
___

#### Version 3.2.0 #####
_Released July 21, 2014, correlating to ExactTarget's 2014-05 Release_<br/>

* Now with Beacons!<br/>
* Refactored the GenericUpdate objects to have the "ET" prefix that they should have had this whole time. This shouldn't create a breaking change for anyone since they weren't yet using these classes for anything.<br/>
* Removed the Geofence class altogether. Now, all of the work it did is handled by statics in ETRegion.<br/>
* Extended ETRegion to handle beacons as well as geofences. This one class describes both types of regions now.<br/>
* Began writing UIAutomation tests.<br/>
* Wrote a local podspec so internal projects can use the SDK directly from source.<br/>
* Regions now count the number of times they're entered or exited. <br/>
* A message can now be fired **after** <br/>
