---
layout: page
title: "Attributes"
subtitle: "Using Attributes"
category: features
date: 2015-05-14 12:00:00
order: 2
---
Attributes contain information used to describe different aspects about a contact. For example, the attribute FavoriteTeamName could contain a string value with the name of the favorite sports team for that contact. You must add any attributes you save with the SDK to your Salesforce Marketing Cloud contact record in advance so the SFMC can connect the values sent by the SDK to the correct contact fields. Attribute names assigned in your mobile app must maintain a 1:1 relationship with attributes stored in the SFMC to ensure segmentation and messaging activities use correct data values.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/Attributes_Step3.png" /><br/>
<br/>

#### Adding an Attribute

<script src="https://gist.github.com/sfmc-mobilepushsdk/96f80418daaa274c36e3.js"></script>

Attributes values and names will be trimmed of leading and trailing blanks.

> Attribute names and values cannot be nil or blank.  As well, attribute names from the following list will not be allowed since they overlap with the names used by the Contacts record.  Please ensure to check the boolean return value to determine if your attribute was accepted to be sent to the SFMC.

<script src="https://gist.github.com/sfmc-mobilepushsdk/34af56f4a7d4a1acd2a3.js"></script>

#### Removing an attribute

Attributes cannot be removed from the Contact record.  However, they can be set back to blank.  Call removeAttribute to remove the value for the named Contact record attribute.

<script src="https://gist.github.com/sfmc-mobilepushsdk/8378b45a6ce0a971f12b.js"></script>

#### Retrieving all attributes saved locally

Attributes are not retrieved from the Contact record.  However, if you wish to get a list of all the attributes you have saved locally using addAttribute, then call getAttributes.

<script src="https://gist.github.com/sfmc-mobilepushsdk/bc224eb2e8c7d46ef4d0.js"></script>