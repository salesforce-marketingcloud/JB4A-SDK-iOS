---
layout: page
title: "Overview"
subtitle: "Overview of Cloud Page Messages"
category: rich-push
date: 2015-05-14 12:00:00
order: 1
---
This section contains information on implementing CloudPage functionality in your mobile app. CloudPages allow you to send either a page created in the CloudPage app to an inbox configured in your app or a combination of a notification and an CloudPage as an alert.

The Salesforce Marketing Cloud must enable the account using this functionality with access to both MobilePush and CloudPages ito successfully create and send CloudPage alerts.

The SDK shows a combination of a notification and CloudPage using the ETLandingPage class when tapping the message.  

For CloudPage-only messages sent to an inbox configured in your app, the app downloads new messages from the Salesforce Marketing Cloud each time the app enters the foreground. The app saves these messages in a view. You must configure this view in your app to display the CloudPage content.

