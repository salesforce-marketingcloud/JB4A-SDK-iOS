---
layout: page
title: "Rich Notifications"
subtitle: "Send Rich Notifications"
category: rich-notifications
date: 2017-10-04 12:00:00
order: 1
---

## Prerequisites

* Make sure that your iOS app is built for iOS 10 or 11.
* Include a service extension for your app that can handle mutable content. See Apple’s documentation.
* Update to version 4.6.0 or higher of the Journey Builder for Apps (JB4A) SDK, which supports iOS 10.
* Make sure that your app is registered for push notifications via the JB4A SDK. See Implement SDK in your iOS App.

Rich notifications include images, videos, titles and subtitles from the MobilePush app, and mutable content. Mutable content can include personalization in the title, subtitle, or body of your message.

Use Xcode 9 from Apple to create a Notification Service Extension.

1. Click **File**.
1. Click **New**.
1. Click **Target**.
2. Select Notification Service Extension.
3. Name and save the new extension.

> Note: Notification Target must be signed by the same XCode Managed Profile as the main project.

## Service Extension Example in Objective C

This example has been taking from the (Marketing Cloud Learning App)[https://github.com/salesforce-marketingcloud/LearningAppIos]. Remember that your code uses a different service extension.

This service extension checks for a "&#95;mediaUrl" element in request.content.userInfo.  If found, it attempts to download the media from the URL , creates a thumbnail-size version, and then adds the attachment. The service extension also checks for a ""&#95;mediaAlt" element in request.content.userInfo.  If found, the service extension uses the element for the body text if there are any problems downloading or creating the media attachment.

A service extension can timeout when it is unable to download.  In this code sample, the service extension delivers the original content with the body text changed to the value in "&#95;mediaAlt".

<script src="https://gist.github.com/sfmc-mobilepushsdk/7745e6cc375704765d4b549d24a12af7.js"></script>

## Service Extension Example in Swift

<script src="https://gist.github.com/sfmc-mobilepushsdk/70864d138f258de4cbca0a49584cdd84.js"></script>
