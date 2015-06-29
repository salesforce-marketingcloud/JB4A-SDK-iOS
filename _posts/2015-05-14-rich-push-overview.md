---
layout: page
title: "Overview"
subtitle: "Overview of Cloud Page Messages"
category: rich-push
date: 2015-05-14 12:00:00
order: 1
---
This section contains information on implementing cloud page functionality in your mobile app. Cloud Pages allow you to send either a page created in the CloudPage app to an Inbox configured in your app or a combination notification/CloudPage as an alert.

Note that the Salesforce account using this functionality must have access to both MobilePush and CloudPages in order to successfully create and send cloud page alerts.

A notification/CloudPage is shown by the SDK using the ETLandingPage class when the message is tapped.  

For CloudPage only messages that are sent to an Inbox configured in your app, new messages are downloaded from the Salesforce Marketing Cloud each time your app is brought into the foreground.  These messages are then saved in a view which you must configure in your app to display the CloudPage content.

