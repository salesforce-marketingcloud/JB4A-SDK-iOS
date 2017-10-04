---
layout: page
title: "Rich Notifications"
subtitle: "Send Rich Notifications"
category: rich-notifications
date: 2017-10-04 12:00:00
order: 1
---

## Prerequisites

* Make sure that your iOS app is built for iOS 10 or higher.
* Include a service extension for your app that can handle mutable content. See Apple’s documentation.
* Update to version 4.6.0 or higher of the Journey Builder for Apps (JB4A) SDK, which supports iOS 10.
* Make sure that your app is registered for push notifications via the JB4A SDK. See Implement SDK in your iOS App.

The Learning App includes an example of the notification service extension for mutable content called MarketingCloudServiceExtension and a sample payload. You can see these examples in NotificationService.m. The sample payload includes a URL for media content. Before the notification displays on a device, the service extension downloads the file from the URL. Then it presents the content in the notification.

## Sample Payload
```
{
  "aps": {
    "alert": {
      "body": "Check out our fall boots! On sale through 11/21."
      },
      "badge": 1,
      "mutable-content": 1
      },
      "imageURL":"https://yourdomain.com/fallsaleboots.jpg"
    }
```
