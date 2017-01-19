---
layout: page
title: "Implement SDK"
subtitle: "Implement SDK in your iOS App"
category: sdk-implementation
date: 2017-01-18 12:00:00
order: 1
---


# MarketingCloudSDK

## Introduction

MarketingCloudSDK exposes and packages the Salesforce Marketing Cloud Mobile Push functionality in a simple, clean and forward-compatible mechanism for iOS 9 and 10.

Using an iOS framework design, a clean and extensible interface and methods compatible with modern iOS practices, MarketingCloudSDK represents the next generation of interfacing with Salesforce Marketing Cloud.

Note: All methods, constants, enums and classes in the JB4ASDK are marked as deprecated but supported as part of the transition to MarketingCloudSDK.

Each method and class in the MarketingCloudSDK interface is fully documented in `AppleDoc` format in the .h files. Please reference the headers for full descriptions and usage notes.

## Project setup

MarketingCloudSDK is packaged as an iOS framework and needs to be linked to your Xcode project.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_01-basicproject.png" /><br/>
<br/>


- Copy the `MarketingCloudSDK.framework` to your project directory.
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_02-folder.png" /><br/>
<br/>
 
- Add `MarketingCloudSDK.framework` as an embedded binary.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_03-addembeddedbinary1.png" /><br/>
<br/>
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_03-addembeddedbinary2.png" /><br/>
<br/>
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_03-addembeddedbinary3.png" /><br/>
<br/>
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_03-addembeddedbinary4.png" /><br/>
<br/>
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_03-addembeddedbinary5.png" /><br/>
<br/>

- When complete you will be able to expand the MarketingCloudSDK.framework file in Xcode's Project Navigator to see all headers included in the SDK.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_04-projectfiles.png" /><br/>
<br/>

- At this point, build your project to ensure that the SDK framework has been included and your project builds and links.

## Header include
To use the SDK in your code, you must first include the framework's umbrella header in any source files you may be accessing the SDK.

    #import <MarketingCloudSDK/MarketingCloudSDK.h>

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_05-addheader.png" /><br/>
<br/>
    
## Configuring the SDK
Configuring the MarketingCloudSDK via the main entry point to the framework is key to successfully using the features of the SDK.

For convenience, define your app id and access token values:

    NSString *const kSFMCAppId                        = @"REPLACE_WITH_YOUR_PROD_APPID";
    NSString *const kSDMCAccessToken                  = @"REPLACE_WITH_YOUR_PROD_ACCESSTOKEN";

Configure the SDK using `sfmc_configureSDK...` via the `[MarketingCloudSDK sfmcSDK]` singleton:

<script src="https://gist.github.com/sfmc-mobilepushsdk/3d9dad542bc2766de44c0a5b9739318b.js"></script>

Be sure to check for success as well as additional information passed back in the `NSError` parameter.
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_06-configuresdk.png" /><br/>
<br/>

See MarketingCloudSDK+Base.h for more information.

## Registering for push notifications

Registration for push notifications is required in order for the Salesforce Marketing Cloud Mobile Push system to function. At a minimum, registering for notifications via `sfmc_registerForRemoteNotificationsWithDelegate...` (iOS 10) or `sfmc_registerUserNotificationSettings...` and `sfmc_registerForRemoteNotifications` (iOS 9) are required, as well as implementing `UIApplication` delegates.

- Register for notifications:

<script src="https://gist.github.com/sfmc-mobilepushsdk/5bd93878bc6225478a0261fcaeae5e13.js"></script>

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_07-registernotifications.png" /><br/>
<br/>

- Implement delegates, making sure to call the methods *within* MarketingCloudSDK to pass notification information to the SDK.

<script src="https://gist.github.com/sfmc-mobilepushsdk/45df2f63abc79bd8c93b2d6e88868dfe.js"></script>

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_07-registernotifications2.png" /><br/>
<br/>

Note: calling `[[MarketingCloudSDK sfmcSDK] sfmc_registerDeviceToken:deviceToken];` is required as part of implementing `application:didRegisterForRemoteNotificationsWithDeviceToken:`.

See `MarketingCloudSDK+Notifications.h` for more information.
    
## Starting location services

To enable location services within the SDK, calling `[[MarketingCloudSDK sfmcSDK] sfmc_startWatchingLocation];` is necessary. This is best done as part of app launch but can be deferred until later.

<script src="https://gist.github.com/sfmc-mobilepushsdk/6a800ec89cdcbdf43d4c5bb9ae5d7606.js"></script>

Note: Failure to call `sfmc_startWatchingLocation` will prevent location-specific push functionality from working.

See `MarketingCloudSDK+Location.h` for more information.

## Complete app launching

Finalize app launching by calling `[[MarketingCloudSDK sfmcSDK] sfmc_applicationLaunchedWithOptions:launchOptions];` so that the MarketingCloudSDK receives launch context.

<script src="https://gist.github.com/sfmc-mobilepushsdk/b176ec422e357aaaa294ce74294f7b51.js"></script>

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/framework_08-finishapplaunch.png" /><br/>
<br/>


## Enabling logging & returning SDK state

MarketingCloudSDK includes useful diagnostic tools to help application developers track behavior within the SDK.

To enable full SDK logging, call `[MarketingCloudSDK sfmc_enableSDKLogging:YES];`.

<script src="https://gist.github.com/sfmc-mobilepushsdk/be6d1f5f00853ae832b8715fea4e13cc.js"></script>

To return the state of the SDK, including all settings, identifiers and attributes, call `[MarketingCloudSDK sfmc_sdkState];`.

<script src="https://gist.github.com/sfmc-mobilepushsdk/ec8a44dba7b3d453d4880fa3594935cf.js"></script>

See `MarketingCloudSDK+Helpers.h` for more information.