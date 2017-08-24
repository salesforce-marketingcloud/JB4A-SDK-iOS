---
layout: page
title: "Overview"
subtitle: "Overview of Cloud Page Messages"
category: rich-push
date: 2015-05-14 12:00:00
order: 1
---
This section contains information on implementing CloudPage functionality in your mobile app. CloudPages allow you to send either a CloudPage in the payload of a notification (CloudPage+Alert) or as a page to be displayed in an inbox configured in your app.

The Marketing Cloud must enable the account using this functionality with access to both MobilePush and CloudPages to successfully create and send CloudPage alerts.

For notifications that are sent that include a CloudPage URL (CloudPage+Alert), the JB4A SDK will open this URL when the message is tapped using the ETWKLandingPagePresenter view controller.  You must include the WebKit.framework in Link Binary With Libraries section of the Build Phases configuration in Xcode.  

For [CloudPage-only messages]({{ site.baseurl }}/rich-push/rich-push-inbox.html) that are displayed in an inbox configured in your app, the app downloads new messages from the Marketing Cloud each time the app enters the foreground. The app saves these messages in a view. You must configure this view in your app to display the CloudPage content.
