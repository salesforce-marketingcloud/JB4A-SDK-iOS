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

