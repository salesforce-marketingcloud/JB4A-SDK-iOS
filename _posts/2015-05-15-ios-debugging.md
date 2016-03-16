---
layout: page
title: "iOS Debugging"
subtitle: "iOS Debugging"
category: trouble
date: 2015-05-14 12:00:00
order: 1
---
Use this information when testing your app and the device either does not receive messages or receives messages sporadically. Testing the app while connected to a corporate Wi-Fi network could cause issues if your IT team does not correctly configure port accessibility (preventing the test device from receiving messages).
<br/>

* <a href="https://developer.apple.com/library/ios/technotes/tn2265/_index.html" target="_blank">APNS Debugging Information</a>
* <a href="https://developer.apple.com/library/ios/technotes/tn2265/tn2265_PersistentConnectionLogging.zip" target="_blank">APNS Debugging Provisioning File</a>
* <a href="http://support.apple.com/kb/TS4264" target="_blank">APNS Port Functionality Information</a>

Ensure that your network team unblocks the following ports to provide communication between the moble device and APNS servers for MobilePush functionality:

* TCP port 5223 (used by devices to communicate to the APNS servers)
* TCP port 2195 (used to send notifications to the APNS servers)
* TCP port 2196 (used by the APNS feedback service)
* TCP port 443 (used as a fallback service for Wi-Fi devices when those devices cannot communicate to the APNS service on port 5223)

You can toggle the SDK logging facility by including the following lines in your code:

<script src="https://gist.github.com/sfmc-mobilepushsdk/c9d6cd88962c843da694.js"></script>

For a complete list of information that the SDK has and it's current state, you can implement getSDKState() as follows:

<script src="https://gist.github.com/sfmc-mobilepushsdk/d77f990a6d13ab3086da.js"></script>