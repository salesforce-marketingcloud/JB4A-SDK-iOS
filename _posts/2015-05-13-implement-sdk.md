---
layout: page
title: "Implement SDK"
subtitle: "Implement SDK in your iOS App"
category: sdk-implementation
date: 2015-05-14 12:00:00
order: 1
---
In order to use the SDK in your Mobile app, complete the steps required to register a device with the Salesforce Marketing Cloud. This process ultimately connects the device to the MobilePush app you created in the [App Center]({{ site.baseurl }}/create-apps/create-apps-overview.html).

1.  In your app development environment, copy the libJB4ASDK-*.a and the header files into your project.
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/iossdk-artifacts.png" /><br/>
<br/>
1.  Select **Project Settings**. 
1.  Select **General**.
1.  Add libJB4ASDK-*.a as a dependency.
1.  Add code in the AppDelegate implementation class to bootstrap the Journey Builder for Apps SDK. Note that you must call configureSDKWithAppId and andAccessToken and provide values from the Salesforce Marketing Cloud app you created in <a href="https://https://appcenter-auth.s1.marketingcloudapps.com/" target="_blank">App Center<a/>.

<script src="https://gist.github.com/sfmc-mobilepushsdk/346819617929db86b842.js"></script>

<br />

You can now deploy and start your app on a physical test device. You can use an iOS simulator for testing, but the simulator will not receive push messages as part of the testing process.

Once you complete this process, you can build your application and send it push notifications from your Marketing Cloud account.