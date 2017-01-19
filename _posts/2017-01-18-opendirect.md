---
layout: page
title: "OpenDirect"
subtitle: "Messages with an OpenDirect URL"
category: sdk-interfaces
date: 2017-01-18 12:00:00
order: 4
---

The OpenDirect customized push message contains a URL in the payload. You must [enable](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#openDirect) this feature in the Marketing Cloud application.

The MarketingCloudSDK will open this URL when the message is tapped using a web view controller. You must include the WebKit.framework in the Link Binary With Libraries section of the Build Phases configuration within Xcode.  

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/OpenDirect.png" /><br/>
<br/>

# OpenDirect Protocol

MarketingCloudSDK supports the `MarketingCloudSDKOpenDirectDelegate` protocol so that an application can be notified of receipt of a notification containing Mobile Push OpenDirect data.

- Add the MarketingCloudSDKOpenDirectDelegate protocol to your class.

<script src="https://gist.github.com/sfmc-mobilepushsdk/d6a43843e91537df3f5602f12dd05872.js"></script>

- Set the delegate to your class.

<script src="https://gist.github.com/sfmc-mobilepushsdk/bbcfb49135729e92ba2aa8ca1bb3d4a2.js"></script>

- Implement the delegate method that will allow you to handle the OpenDirect URL with your own code. This delegate method will be called when a notification is tapped that has a OpenDirect URL in the payload.

<script src="https://gist.github.com/sfmc-mobilepushsdk/bbe2125e959395915236629e63f7313a.js"></script>

- Implement the delegate method that will indicate whether you want this delegate called when the app is in the foreground.

<script src="https://gist.github.com/sfmc-mobilepushsdk/e11d8ef75f961888499873208d3e9e76.js"></script>

For more information, see `MarketingCloudSDK+OpenDirect.h`.