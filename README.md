# ExactTarget MobilePush SDK for iOS

This is the git repository for the ET MobilePush SDK for iOS. 

For more information, please see [Code@ExactTarget](http://code.exacttarget.com), or visit the online documentation at [here](http://exacttarget.github.io/MobilePushSDK-iOS).

## Release History

### Version 3.0

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

* Bug fixes. 

### Version 2.1.2

* Various bug fixes and enhancements. 
* Deprecated internal functionality that was no longer required. 

### Version 2.1.1

* Changes required in preparation for iOS 7 compatibilty. 

### Version 2.1.0

* OpenDirect payloads containing a full URL will automatically present themselves on app load. This functionality only works if there is no OpenDirect Delegate set. 
* Verious bug fixes and improvements. 

### Version 2.0.1

* Updated Urban Airship library to 1.4.0 to be compliant with recent Apple approval changes. 

### Version 2.0.0

* Support for Access Tokens in place of Client ID/Secret. Access Token is provided by Code@ExactTarget during app registrations. 
* Added support for Subscriber Key. 
* Added support for determining push enabled state based on the Notifications tab in Settings.
* Significantly reworked sample project to demonstrate new features and fix some bugs. 


### Version 1.1.1

* First public version!
* Support for OpenDirect, including the ExactTargetOpenDirectDelegate
* Bugfixes around timezones and GMT-0000 and attribute processing
