---
layout: default
title: "README"
---
#Journey Builder for Apps iOS SDK

This is the documentation for the Salesforce Marketing Cloud Journey Builder for Apps iOS SDK which can be found on here:<br/>
<a href="https://github.com/ExactTarget/JB4A-SDK-iOS" target="_blank">JB4A iOS SDK GitHub Repository</a><br>

The Apple docs for the SDK can be found here:<br/>
<a href="{{ site.baseurl }}/appledoc/index.html" target="_blank">iOS SDK Apple Docs</a>

## Release History

#### Version 4.0.3
**(supported)**
_Released November 4, 2015, correlating to the Salesforce Marketing Cloud 2015-06.HF Release_<br/>

* MOBILESDK-439 - iOS SDK returning latitude/longitude with commas instead of decimal points for certain locales.
* MOBILESDK-428 - Database corruption following VACUUM
* MOBILESDK-427 - Fix for ETEvent analytics to handle Array of dictionaries.

#### Version 4.0.2
**(supported)**
_Released October 2, 2015, correlating to the Salesforce Marketing Cloud 2015-06 Release_<br/>

* MOBILESDK-327 - Fix for missing keychain item when applications are restored from an unencrypted backup.
* MOBILESDK-326 - Only send registration data if different from the last one sent
* MOBILESDK-311 - Application crashing in iOS SDK
* MOBILESDK-310 - Reduce Location REST call traffic to SFMC
* MOBILESDK-300 - Application crashing in iOS SDK

> This version of the JB4A SDK introduces iOS Keychain usage. To ensure that your app retains any relevant data across user backups and restores, encourage your app users to implement encrypted backups for their devices. Otherwise, information (such as tags, attributes, and subscriber keys) will not persist.

#### Version 4.0.1
**(supported)**
_Released July 23rd, 2015_<br/>

* MPUSH-3856 - SUPPORT - Upgrade to MobilePush iOS SDK 4.0.0 from SDK 3.4.2 Causes App to Freeze<br/> 

#### Version 4.0.0
**(supported)**
_Released June 24th, 2015, correlating to the Salesforce Marketing Cloud 2015-04 Release_<br/>

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

~~~

BOOL successful = NO;

successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Prod
                                              andAccessToken:kETAccessToken_Prod
                                               withAnalytics:YES
                                         andLocationServices:YES
                                               andCloudPages:YES
                                             withPIAnalytics:YES
                                                       error:&error];

~~~


<!--**Recommended Coding Changes** -->

___

#### Version 3.4.2 ####
**(supported)**
_Released March 9, 2015, correlating to Salesforce Marketing Cloud 2015-02 Release_

* Fix beacon payload message handling for personalized messages
 Added initial PI Analytics - off by default in the SDK
 Enabled IOS Data Protection on SQLite DB. Using NSFileProtectionCompleteUnlessOpen. User must set a passcode to enable.
 Disabled caching of URL responses

___

#### Version 3.4.1 #### 
**(supported)**
_Released December 11, 2014_

 * HF.1 - fixed analytics rest route.

___

#### Version 3.4.0 ####
**(supported)**
_Released November 17, 2014, correlating to Salesforce Marketing Cloud 2014-08 Release_

* MPUSH-2753 - Fix for someone calling registerForRemoteNotificationTypes on an IOS8 device. We will transform the call to into the IOS8 call/pair registerUserNotificationSettings and registerForRemoteNotifications using the same alert types (i.e. sound, badges, alerts). This is so push registration will work if the customer doesn't change their code at all and just recompiles with Xcode6 but they want to run on an IOS8 device.<br/>
Calling registerForRemoteNotificationTypes while running on an IOS8 device will fail and you will not get a push token.<br/>
* MPUSH-2752 - Rename PracticeField app to JB4A SDK Explorer (iOS).<br/>
* MPUSH-2855 - Geofence Messages not always displaying when expected.<br/>
* MPUSH-2854 - iOS Beacons not working.<br/>
* MPUSH-3010 - Payload for iOS Local Messages.<br/>

___

#### Version 3.3.0 #####
**(supported)**
_Released August 25, 2014, correlating to ExactTarget's 2014-06 Release_<br/>

* MPUSH-2560 - Continued Beacon work to meet further requirements.<br/>
* MPUSH-2488 - Added device locale to registrations.<br/>
* MPUSH-2472 - Introduced ETEvent to track statistics and such going forward. This also includes the addition of the Bulk Uploader Shim and related functionality.<br/>
* MPUSH-2513 - Added the ability to retrieve inactive fences from the SDK's cache. This was previously impossible.<br/>
* MPUSH-2536 - ETLog can now be turned on or off in production. It defaults to off.<br/>
___

#### Version 3.2.0 #####
**(This version no longer supported as of June 19, 2015.)**<br/>
_Released July 21, 2014, correlating to ExactTarget's 2014-05 Release_<br/>

* Now with Beacons!<br/>
* Refactored the GenericUpdate objects to have the "ET" prefix that they should have had this whole time. This shouldn't create a breaking change for anyone since they weren't yet using these classes for anything.<br/>
* Removed the Geofence class altogether. Now, all of the work it did is handled by statics in ETRegion.<br/>
* Extended ETRegion to handle beacons as well as geofences. This one class describes both types of regions now.<br/>
* Began writing UIAutomation tests.<br/>
* Wrote a local podspec so internal projects can use the SDK directly from source.<br/>
* Regions now count the number of times they're entered or exited. <br/>
* A message can now be fired **after** <br/>
