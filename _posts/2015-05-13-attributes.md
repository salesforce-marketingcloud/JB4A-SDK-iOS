---
layout: page
title: "Attributes"
subtitle: "Using Attributes"
category: features
date: 2015-05-14 12:00:00
order: 2
---
To implement segmentation by attributes, include code to reference attributes in the app. Any attributes you save with the SDK must be added to your Marketing Cloud Contact record in advance so that the Marketing Cloud can connect the values sent by the SDK to the correct Contact fields.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/Attributes_Step3.png" /><br/>
<br/>

~~~ 
    // Add an attribute
    [[ETPush pushManager] addAttributeNamed:"FavoriteTeam" value:favoriteTeamName];
~~~

~~~ 
    // Remove an attribute
    [[ETPush pushManager] removeAttributeNamed:favoriteTeamName];
~~~

~~~ 
    // Get all attributes
    NSDictionary *attributes = [[ETPush pushManager] allAttributes];
~~~