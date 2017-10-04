---
layout: page
title: "CloudPage Alert Overview"
subtitle: "Implement CloudPage functionality in your mobile app"
category: inbox
date: 2015-05-14 12:00:00
order: 2
---

CloudPages allow you to send either a CloudPage in the payload of a notification (CloudPage+Alert) or as a page to be displayed in an inbox configured in your app.

Marketing Cloud must enable the account using this functionality with access to both MobilePush and CloudPages to successfully create and send CloudPage alerts.

For notifications that are sent that include a CloudPage URL (CloudPage+Alert), the JB4A SDK will open this URL when the message is tapped using the ETWKLandingPagePresenter view controller.  You must include the WebKit.framework in Link Binary With Libraries section of the Build Phases configuration in Xcode.  

For [CloudPage-only messages]({{ site.baseurl }}/inbox/inbox.html) that are displayed in an inbox configured in your app, the app downloads new messages from the Marketing Cloud each time the app enters the foreground. The app saves these messages in a view. You must configure this view in your app to display the CloudPage content.
