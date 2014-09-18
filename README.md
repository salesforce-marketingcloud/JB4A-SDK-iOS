# ExactTarget MobilePush SDK for iOS

This is the git repository for the ET MobilePush SDK for iOS.

For more information, please see [Code@ExactTarget](http://code.exacttarget.com), or visit the online documentation [here](http://exacttarget.github.io/MobilePushSDK-iOS).

## Release History
As of July 2014, we have clarified the version numbering of the SDK and versions that will be supported.  For more information see [here](https://code.exacttarget.com/apis-sdks/mobilepush-sdks/mobile-push-sdk.html).

#### Version 3.3.0
_Released August 25, 2014, correlating to ExactTarget's 2014-06 Release_
_(supported)_

This latest commit clears up confusion with the iOS8 SDK library.  The libetpushsdk-3.3.0.a is supported in Xcode 5 and 6 and can be built for iOS8, iOS7, and iOS6.

* MPUSH-2560 - Continued Beacon work to meet further requirements.
* MPUSH-2488 - Added device locale to registrations. 
* MPUSH-2472 - Introduced ETEvent to track statistics and such going forward. This also includes the addition of the Bulk Uploader Shim and related functionality. 
* MPUSH-2513 - Added the ability to retrieve inactive fences from the SDK's cache. This was previously impossible.
* MPUSH-2536 - ETLog can now be turned on or off in production. It defaults to off.

### Version 3.2.0 
_Released July 21, 2014, correlating to ExactTarget's 2014-05 Release_
_(supported)_

* MPUSH-2309 - Addressing an issue related to retrieving location messages from the database.
* MPUSH-2141 - Add the "DEBUG" tag to debug builds.
* MPUSH-2162 - Addressing an issue where the ETLandingPagePresenter doesn't display the UIToolbar correctly.
* MPUSH-2176 - Location messages without a sound defined can cause a crash.
* MPUSH-2313 - Added hardware identifier to the registration payload and corresponding accessor to ETPush (ETPush#hardwareIdentifier).
* MPUSH-2427 - Fixes around CloudPages functionality.
* MPUSH-2448 - Added delete functionality to CloudPages.

### Version 3.1.1
_Released April 15, 2014_
_(supported)_

* MPUSH-2047 - Addresses and issue where the SDK was calling an iOS7-only method, breaking backwards compatibility. Returns the SDK to iOS6+ compatibility. 

### Version 3.1.0
_Released April 11, 2014, correlating to ExactTarget's 2014-03 Release_
_(supported)_

* New sample project to more simply demonstrate the SDK, as well as some of it's new features. Also, addresses several issues with references and functionality updates.
* MPUSH-1936 - Fix to account for null messagesPerPeriod
* MPUSH-1936 - Message limiting not setting correctly
* MPUSH-1796 - Tags weren't repopulating after the device killed the app.
* MPUSH-1871 - Instantiating the SDK from a GCD thread can result in a crash.
* MPUSH-1798 - Calling removeTag rapidly can result in a crash.
* The SDK build script has been rewritten to create a 64-bit slice, suitable for development against the a 64-bit Simulator or A7 based devices. It is still ARC-aware.

### Version 3.0

<span class="alert">_This version no longer supported as of July 21, 2014._</span>

This version has a lot of new functionality, and a few changes that may be important to note. Here's a quick summary. For more, please visit the full documentation.

#### Overview

* Introduction of **ETLocationManager** to support geofenced messages and the beginning of location-based messaging.
* Tag and Attribute caching.
* Rewritten data management engine, with better, more fault-tolerant data transmission to ExactTarget and caching in the event of data failure.
* Quieter logging.

#### New and Changed Methods
* **configureSDKWithAppId:andAccessToken:** is being replaced with **configureSDKWithAppId:andAccessToken:withAnalytics:andLocationServices:andCloudPages:**. This new method gives you finer-grained controls over the features enabled in the MobilePush SDK. These flags act as global on/off switches, so if you intend to use any of these features in the app, they must be turned on here. The legacy configuration method is still in place, and defaults to *YES* for all of the feature flags. You need not change the method, but are encouraged to over time to reflect actual usage.
* **removeTag:** had a signature change, previously returning *void*, but now echoing back the submitted tag in the event of a successful removal, or nil if that tag was not removed (it may not have been previously set, previously removed, etc). This change shouldn't impact existing code.
* **allAttributes** was added to ETPush to return an NSDictionary of the current attributes. This is a companion to the already present **allTags**.
* **ETLocationManager** introduced to handle location services in general. Please check it's documentation and header for an overview of what is available and how to use it.

#### Deprecations
* No deprecations in this version.


### Version 2.1.3
<span class="alert">_This version no longer supported as of July 21, 2014._</span>
* Bug fixes.

### Version 2.1.2
<span class="alert">_This version no longer supported as of July 21, 2014._</span>
* Various bug fixes and enhancements.
* Deprecated internal functionality that was no longer required.

### Version 2.1.1
<span class="alert">_This version no longer supported as of July 21, 2014._</span>
* Changes required in preparation for iOS 7 compatibilty.

### Version 2.1.0
<span class="alert">_This version no longer supported as of July 21, 2014._</span>
* OpenDirect payloads containing a full URL will automatically present themselves on app load. This functionality only works if there is no OpenDirect Delegate set.
* Verious bug fixes and improvements.

### Version 2.0.1
<span class="alert">_This version no longer supported as of July 21, 2014._</span>
* Updated Urban Airship library to 1.4.0 to be compliant with recent Apple approval changes.

### Version 2.0.0
<span class="alert">_This version no longer supported as of July 21, 2014._</span>
* Support for Access Tokens in place of Client ID/Secret. Access Token is provided by Code@ExactTarget during app registrations.
* Added support for Subscriber Key.
* Added support for determining push enabled state based on the Notifications tab in Settings.
* Significantly reworked sample project to demonstrate new features and fix some bugs.


### Version 1.1.1
<span class="alert">_This version no longer supported as of July 21, 2014._</span>
* First public version!
* Support for OpenDirect, including the ExactTargetOpenDirectDelegate
* Bugfixes around timezones and GMT-0000 and attribute processing
