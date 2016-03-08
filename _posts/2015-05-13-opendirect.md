---
layout: page
title: "OpenDirect"
subtitle: "Messages with an OpenDirect URL"
category: features
date: 2015-05-14 12:00:00
order: 4
---

The OpenDirect customized push message contains a URL that opens in a web view. You must [enable](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#openDirect) this feature in the Marketing Cloud application. Craft your application to react appropriately when the mobile device receives that type of push message.

By default, an OpenDirect message will open the specified webpage.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/OpenDirect.png" /><br/>
<br/>

Upon receiving a MobilePush message with OpenDirect, the JB4A SDK will use the ETLandingPagePresenter class to open and present the URL specified in the OpenDirect key. ETLandingPagePresenter opens automatically upon tap of a notification. That action pops up a UIWebView with a toolbar, shows the location specified by the URL reference, and waits for dismissal. The JB4A SDK does not use a WKWebView or the SFSafariViewController.

To override this default behavior, provide your own functionality by implementing the OpenDirect protocol and delegate:

1. Add the ExactTargetOpenDirectDelegate protocol to your class.

~~~
@interface PUDAppDelegate : UIResponder <…, ExactTargetOpenDirectDelegate>
{ … }
~~~

1. Implement the following required delegate method.

~~~
-	(void)didReceiveOpenDirectMessageWithContents:(NSString *)payload { … }
~~~

See the [ExactTargetOpenDirectDelegate Protocol Reference for more information](http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/appledoc/Protocols/ExactTargetOpenDirectDelegate.html).