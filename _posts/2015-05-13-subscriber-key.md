---
layout: page
title: "Subscriber Key"
subtitle: "Updating Subscriber Key"
category: features
date: 2015-05-14 12:00:00
order: 1
---
Use setSubscriberKey() to implement a specific value as the unique identifier for the Contact record. You can use a mobile number, email address, device ID, or other appropriate value as necessary. Subscriber keys cannot include a null or blank value.

By default, the Salesforce Marketing Cloud generates a default subscriberKey value if your app does not set that value using setSubscriberKey(). The getSubscriberKey() method returns the value set in the last setSubscriberKey() call and will return a nil value until you call setSubscriberKey(). The getSubscriberKey() method retrieves only the local copy of the value and not the value from the Salesforce Marketing Cloud. 

The SDK will send changes to the subscriberKey to the SFMC in a batch one minute after the first change to any SFMC data.  If the data fails to send, then it will retry in one minute intervals until the app is suspended.  If the send is unsuccessful before the app is suspended, the data will be sent the next time the app is opened.

<script src="https://gist.github.com/sfmc-mobilepushsdk/87841718df45af4354c8.js"></script>

> The subscriberKey will be trimmed of leading and trailing blanks.
