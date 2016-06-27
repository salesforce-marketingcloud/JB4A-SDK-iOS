---
layout: page
title: "OpenDirect"
subtitle: "Messages with an OpenDirect URL"
category: features
date: 2015-05-14 12:00:00
order: 4
---

The OpenDirect customized push message contains a URL in the payload. You must [enable](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#openDirect) this feature in the Marketing Cloud application.

The JB4A SDK will open this URL when the message is tapped using the ETWKLandingPagePresenter view controller.  You must include the WebKit.framework in the Link Binary With Libraries section of the Build Phases configuration within Xcode.  

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/OpenDirect.png" /><br/>
<br/>

You can override this functionality, by implementing the ExactTargetOpenDirectDelegate which will allow you to handle this URL in any fashion you choose.

1.	Add the ExactTargetOpenDirectDelegate protocol to your class.

	<script src="https://gist.github.com/sfmc-mobilepushsdk/ae6e3de55dd3bde9747071d51363a8fb.js"></script>

1. Set the delegate to your class.

    <script src="https://gist.github.com/cctman/afedad34e7a8cd9c8c59e2b5d4f611af.js"></script>

1.	Implement the delegate method that will allow you to handle the open direct URL with your own code.  This delegate method will be called when a notification is tapped that has an OpenDirect URL in the payload.

	<script src="https://gist.github.com/sfmc-mobilepushsdk/f63fdac81f45a365c258.js"></script>

1.  Implement the delegate method that will indicate whether you want this delegate called when the app is in the foreground.

	<script src="https://gist.github.com/sfmc-mobilepushsdk/1ab86534e81f5ff1be7b.js"></script>

For more information see the [ExactTargetOpenDirectDelegate Protocol Reference](http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/appledoc/Protocols/ExactTargetOpenDirectDelegate.html).