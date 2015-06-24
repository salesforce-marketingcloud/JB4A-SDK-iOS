---
layout: page
title: "Subscriber Key"
subtitle: "Updating Subscriber Key"
category: features
date: 2015-05-14 12:00:00
order: 1
---
Use setSubscriberKey() to implement a specific value as the unique identifier for the contact. You can use a mobile number, email address, device ID, or other appropriate value as necessary.

By default, the Salesforce Marketing Cloud generates a default subscriberKey value if your app does not set that value using setSubscriberKey(). The getSubscriberKey() method returns the value set in the last setSubscriberKey() call and will return a nil value until you call setSubscriberKey(). The getSubscriberKey() method retrieves only the local copy of the value and not the value from the Salesforce Marketing Cloud.

~~~
    // Set a subscriber key
    [[ETPush pushManager] setSubscriberKey:@"key"];
~~~