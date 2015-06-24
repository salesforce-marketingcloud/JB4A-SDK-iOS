---
layout: page
title: "Background Pushes"
subtitle: "Using Background Pushes"
category: features
date: 2015-05-14 12:00:00
order: 9
---
####Background Push Messages for MobilePush
This document contains conceptual and procedural information about sending a background push message to a mobile app using the MobilePush app and the REST API.

####What are Background Push Messages
A background push message appears on a mobile app without triggering a visual or audible alert on the mobile device. Examples include subscriptions read inside the iOS Newsstand app or updates to messages within an app that do not require notifications.

####How to Send Background Push Messages
Follow the steps below to create and send background push messages:

Create an API-triggered MobilePush message.
Ensure you set the content-available property to 1.
Set the override property to true.
Include AMPscript in the messageText property as a placeholder for the overriden text. For example, you can include the value %%[]%%.
Use the sample payload below as a model for your own message:

~~~

Content-Type: application/json
{
    "Override": true,
    "MessageText":"%%[]%%",
    "SendTime": "2012-10-31 09:00",
     "content-available":1
}
~~~

Note that you cannot use badge count or sound as part of the message. Once you create the original message, you can pass text to the message using subsequent messages as part of the Override value.