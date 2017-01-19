---
layout: page
title: "iOS Debugging"
subtitle: "iOS Debugging"
category: trouble
date: 2017-01-18 12:00:00
order: 1
---

#### Additional Resources

Use this information when testing your app and the device either does not receive messages or receives messages sporadically. Testing the app while connected to a corporate Wi-Fi network could cause issues if your IT team does not correctly configure port accessibility (preventing the test device from receiving messages).
<br/>

* <a href="https://developer.apple.com/library/ios/technotes/tn2265/_index.html" target="_blank">APNS Debugging Information</a>
* <a href="https://developer.apple.com/library/ios/technotes/tn2265/tn2265_PersistentConnectionLogging.zip" target="_blank">APNS Debugging Provisioning File</a>
* <a href="http://support.apple.com/kb/TS4264" target="_blank">APNS Port Functionality Information</a>

#### Unblock network ports

Ensure that your network team unblocks the following ports to provide communication between the moble device and APNS servers for MobilePush functionality:

* TCP port 5223 (used by devices to communicate to the APNS servers)
* TCP port 2195 (used to send notifications to the APNS servers)
* TCP port 2196 (used by the APNS feedback service)
* TCP port 443 (used as a fallback service for Wi-Fi devices when those devices cannot communicate to the APNS service on port 5223)

#### Add debugging statements to the log

You can extend the SDK logging facility by including the following lines in your code, giving you a mechanism to capture all logging for application use (in your own logging implementation, for example):

<script src="https://gist.github.com/sfmc-mobilepushsdk/255bd1e0aecd97b3c76c40a6419c9203.js"></script>

#### Add SDK State information to log

For a complete list of information that the SDK has and it's current state, you can implement sfmc_sdkState as follows:

<script src="https://gist.github.com/sfmc-mobilepushsdk/ec8a44dba7b3d453d4880fa3594935cf.js"></script>