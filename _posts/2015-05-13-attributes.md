---
layout: page
title: "Attributes"
subtitle: "Using Attributes"
category: features
date: 2015-05-14 12:00:00
order: 2
---
Attributes contain information used to describe different aspects about a contact. For example, the attribute **favoriteTeamName** could contain a string value with the name of the favorite sports team for that contact. To implement segmentation by attributes, include code to reference attributes in the app. You must add any attributes you save with the SDK to your Marketing Cloud contact record in advance so the Marketing Cloud can connect the values sent by the SDK to the correct contact fields. Attribute names assigned in your mobile app must maintain a 1:1 relationship with attributes stored in the Marketing Cloud to ensure segmentation and messaging activities use correct data values.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/Attributes_Step3.png" /><br/>
<br/>

####Adding an Attribute
~~~ 
    // Add an attribute
    [[ETPush pushManager] addAttributeNamed:"FavoriteTeam" value:favoriteTeamName];
~~~

####Removing an attribute
~~~ 
    // Remove an attribute
    [[ETPush pushManager] removeAttributeNamed:favoriteTeamName];
~~~

####Retrieving all available attributes
~~~ 
    // Get all attributes
    NSDictionary *attributes = [[ETPush pushManager] allAttributes];
~~~