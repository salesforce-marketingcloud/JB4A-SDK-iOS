---
layout: page
title: "Subscriber Key"
subtitle: "Updating Subscriber Key"
category: features
date: 2015-05-14 12:00:00
order: 1
---
Use `setSubscriberKey` to implement a specific value as the unique identifier for the Contact record. You can use a mobile number, email address, device ID, or other appropriate value as necessary. Subscriber keys cannot include a null or blank value.

By default, the Marketing Cloud generates a default subscriberKey value if your app does not set that value using `setSubscriberKey`. The `getSubscriberKey` method returns the value set in the last `setSubscriberKey` call and will return a nil value until you call `setSubscriberKey`. The `getSubscriberKey` method retrieves only the local copy of the value and not the value from the Marketing Cloud. 

{{ site.retryAndRESTdelayMessage }}

<script src="https://gist.github.com/sfmc-mobilepushsdk/87841718df45af4354c8.js"></script>

> The subscriberKey will be trimmed of leading and trailing blanks.

To retrieve the subscriber key previously set using `setSubscriberKey`, call `getSubscriberKey`

<script src="https://gist.github.com/sfmc-mobilepushsdk/d1f236b27e14fd5596c7.js"></script>
