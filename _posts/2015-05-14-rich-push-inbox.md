---
layout: page
title: "Inbox"
subtitle: "Cloud Page Inbox"
category: rich-push
date: 2015-05-14 12:00:00
order: 3
---
For CloudPage-only Messages, the JB4A SDK will download new messages each time your app comes into the foreground.

You must configure your app to display these messages. The SDK provides a TableView Datasource for you to use in a ViewController to display the CloudPage-only messages sent from the Marketing Cloud. The ViewController you create will essentially create an inbox in your app to display these messages.  When these messages are downloaded, they are added to the Datasource only.  No alerts for these messages are displayed.

<script src="https://gist.github.com/sfmc-mobilepushsdk/f278db5683b7aec102f3.js"></script>

You can override this functionality, by implementing the ExactTargetCloudPageWithAlertDelegate which will allow you to handle the URL in any fashion you choose.

1.	Add the ExactTargetCloudPageWithAlertDelegate protocol to your class.

	<script src="https://gist.github.com/sfmc-mobilepushsdk/f582cc17d22723d590c28c706a42e7d1.js"></script>

1. Set the delegate to your class.

    <script src="https://gist.github.com/sfmc-mobilepushsdk/e3df64163d067f3b559b84c057b82499.js"></script>

1.	Implement the delegate method that will allow you to handle the CloudPage URL with your own code.  This delegate method will be called when a notification is tapped that has an CloudPage URL in the payload.

	<script src="https://gist.github.com/sfmc-mobilepushsdk/a8a1922c436db0224038c9e337dc8a99.js"></script>

1.  Implement the delegate method that will indicate whether you want this delegate called when the app is in the foreground.

	<script src="https://gist.github.com/sfmc-mobilepushsdk/74ca87449cf6e782a8ddbb3ebaea3586.js"></script>

For more information see the [ExactTargetCloudPageWithAlertDelegate Protocol Reference](http://salesforce-marketingcloud.github.io/JB4A-SDK-iOS/appledoc/Protocols/ExactTargetCloudPageWithAlertDelegate.html).