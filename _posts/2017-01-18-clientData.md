---
layout: page
title: "Contact Key, Tags and Attributes"
subtitle: "Updating Contact Key, Tags and Attributes"
category: sdk-interfaces
date: 2017-01-18 12:00:00
order: 2
---

`MarketingCloudSDK+ClientData.h` contains methods used for managing Marketing Cloud values related to contact data and segmentation keys.

## Contact Key
To manage a Marketing Cloud contact key, use 

<script src="https://gist.github.com/sfmc-mobilepushsdk/1520023b127b578d3e3414dca14c10b4.js"></script>

to implement a specific value as the unique identifier for the Contact record. You can use a mobile number, email address, device ID, or other appropriate value as necessary. Contact keys cannot include a null or blank value.

By default, the Marketing Cloud generates a default contactKey value if your app does not set that value using `sfmc_setContactKey:`. The `sfmc_contactKey` method returns the value set in the last `sfmc_setContactKey:` call and will return a nil value until you call `sfmc_setContactKey:`. The `sfmc_contactKey` method retrieves only the local copy of the value and not the value from the Marketing Cloud.

The SDK will send changes to the contact key to the Marketing Cloud with a REST call one minute after the first change to any Marketing Cloud data. If the REST call fails (no network for example), then it will retry in one minute intervals until the app is suspended. If the send is unsuccessful before the app is suspended, the data will be sent the next time the app is opened. It will take up to 5 minutes for this value to be recorded in the Contact record once the REST call is made by the SDK.

## Tags

To implement contact segmentation by tags, include code to set tags for subscriptions as defined by user choice.

You can use tags to collect information from the mobile app. Tags will appear in contact records for use in segmentation. Use tags for unstructured data or data that can contain many potential unknown values. For example, you can use tags when the number of potential attribute names exceeds the number of potential values of an individual attribute (such as the favorite brand specified by a contact). Because tags do not require linkage to an attribute present in the Marketing Cloud, you can assign whatever information you wish as part of the tag.

The SDK trims all leading and trailings blanks from tag values.

To set tags, use the methods `sfmc_setTags:` (an array of tag strings) or `sfmc_setTag:` (a single tag string). To retrieve tags in use by the SDK, use the method `sfmc_tags`. Removing tags can be accomplished by `sfmc_removeTags:` (an array of tag strings) or `sfmc_removeTag:` (a single tag string).

The SDK will send changes to Tags to the Marketing Cloud with a REST call one minute after the first change to any Marketing Cloud data. If the REST call fails (no network for example), then it will retry in one minute intervals until the app is suspended. If the send is unsuccessful before the app is suspended, the data will be sent the next time the app is opened. It will take up to 5 minutes for this value to be recorded in the Contact record once the REST call is made by the SDK.

<script src="https://gist.github.com/sfmc-mobilepushsdk/1376dac6a9b550bb1d91418d37d2314b.js"></script>

## Attributes

Attributes contain information used to describe different aspects about a contact. For example, the attribute FavoriteTeamName could contain a string value with the name of the favorite sports team for that contact. You must add any attributes you save with the SDK to your Marketing Cloud contact record in advance so the Marketing Cloud can connect the values sent by the SDK to the correct contact fields. Attribute names assigned in your mobile app must maintain a 1:1 relationship with attributes stored in the Marketing Cloud to ensure segmentation and messaging activities use correct data values.

Attributes values and names will be trimmed of leading and trailing blanks.

Attribute names from the following list will not be allowed since they overlap with the names used by the Contacts record. Please ensure to check the setter return value to determine if your attribute was accepted to be sent to the Marketing Cloud.

<script src="https://gist.github.com/sfmc-mobilepushsdk/34af56f4a7d4a1acd2a3.js"></script>

To set attributes in the SDK, use `sfmc_addAttributeNamed:value:` passing an attribute name and its value. To add multiple attributes, use `sfmc_addAttributes:` passing an array of key/value NSDictionary objects, like so:

All attributes can be retrieved as a NSSet of key/value NSDictionary objects via `sfmc_attributes`.

Removing attributes can be accomplished by using `sfmc_removeAttributesNamed` (an array of attribute name strings) or `sfmc_removeAttributeNamed:` (a single attribute name).

<script src="https://gist.github.com/sfmc-mobilepushsdk/757f884c990c6268c223c0ea5170da26.js"></script>

The SDK will send changes to attributes to the Marketing Cloud with a REST call one minute after the first change to any Marketing Cloud data. If the REST call fails (no network for example), then it will retry in one minute intervals until the app is suspended. If the send is unsuccessful before the app is suspended, the data will be sent the next time the app is opened. It will take up to 5 minutes for this value to be recorded in the Contact record once the REST call is made by the SDK.
