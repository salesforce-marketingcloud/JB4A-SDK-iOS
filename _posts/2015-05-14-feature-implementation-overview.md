---
layout: page
title: "Overview"
subtitle: "Feature Implementation"
category: features
date: 2015-06-16 12:00:00
order: 1
---
This section contains information on implementing various feature implementations in your mobile app. 

There is a basic concept often overlooked by developers. The functional flow of remote notifications and who is responsible and when. The graph below demonstrates the flow between Salesforce and Apple's APNS servers. 

<br />
<img class="img-responsive" src="{{ site.baseurl }}/assets/Overview_Features_Step1_b.png" /><br />
<br />

There are two major parts to the remote push notification process. The registration and the push to the end device.

* Registration Process
1. In the registration process the app first makes a registration call to iOS.
1. iOS will then request from APNS a device token.
1. The device receives the device token.
1. And finally the app sends the token to the Salesforce Marketing Cloud.

<br/>

* Push Process
1. After registration is complete, the user makes a push from the Marketing Cloud to Apple's APNS servers.
1. The APNS servers will then process and push the notification to your application.