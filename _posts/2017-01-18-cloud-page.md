---
layout: page
title: "Cloud Page Messages"
subtitle: "Cloud Page Messages"
category: rich-push
date: 2017-01-18 12:00:00
order: 1
---
This section contains information on implementing CloudPage functionality in your mobile app. CloudPages allow you to send either a CloudPage in the payload of a notification (CloudPage+Alert) or as a page to be displayed in an inbox configured in your app.

The Marketing Cloud must enable the account using this functionality with access to both MobilePush and CloudPages to successfully create and send CloudPage alerts.

For notifications that are sent that include a CloudPage URL (CloudPage+Alert), the MarketingCloudSDK will open this URL when the message is tapped using a web view controller.  You must include the WebKit.framework in Link Binary With Libraries section of the Build Phases configuration in Xcode.  

For [CloudPage-only messages]({{ site.baseurl }}/rich-push/rich-push-inbox.html) that are displayed in an inbox configured in your app, the app downloads new messages from the Marketing Cloud each time the app enters the foreground. The app saves these messages in a view. You must configure this view in your app to display the CloudPage content.


# Cloud Page Inbox
For CloudPage-only Messages, the MarketingCloudSDK will download new messages each time your app comes into the foreground.

You must configure your app to display these messages. The SDK provides a UITableView datasource for you to use in a UIViewController to display the CloudPage-only messages sent from the Marketing Cloud. The UIViewController you create will essentially create an inbox in your app to display these messages. When these messages are downloaded, they are added to the datasource only. No alerts for these messages are displayed.

<script src="https://gist.github.com/sfmc-mobilepushsdk/f9efbd7a58bc70db38baf8d5b0f98223.js"></script>

You can override this functionality by implementing the MarketingCloudSDKCloudPageWithAlertDelegate, which will allow you to handle the URL any way you choose.

- Add the MarketingCloudSDKCloudPageWithAlertDelegate protocol to your class.

<script src="https://gist.github.com/sfmc-mobilepushsdk/cef313e30294a39ad7229bcad5407be3.js"></script>

- Set the delegate to your class.

<script src="https://gist.github.com/sfmc-mobilepushsdk/26efe820dc973941822f016d97b8087f.js"></script>

- Implement the delegate method that will allow you to handle the CloudPage URL with your own code. This delegate method will be called when a notification is tapped that has a CloudPage URL in the payload.

<script src="https://gist.github.com/sfmc-mobilepushsdk/1b0542dc46f3016f964ea27aef15a38c.js"></script>

- Implement the delegate method that will indicate whether you want this delegate called when the app is in the foreground.

<script src="https://gist.github.com/sfmc-mobilepushsdk/3263e4c68a6b66cc1356c56680fe7498.js"></script>

For more information, see `MarketingCloudSDK+CloudPage.h`.