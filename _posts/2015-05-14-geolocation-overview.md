---
layout: page
title: "Overview"
subtitle: "Implement Location Services"
category: location
date: 2015-05-14 08:44:12
order: 1
---
The Journey Builder for Apps SDK uses the device location capabilities to monitor entry and exit of Geofence locations to display notification messages. These fences and messages are created in the Marketing Cloud. The SDK downloads geofences and their corresponding messages and triggers those messages when a mobile device crosses a geofence boundary. You must first [bootstrap]({{ site.baseurl }}/location/geolocation.html) the SDK to use Location Services.

Note that the Marketing Cloud must enable your account with access to MobilePush and Location Services in order to successfully use this functionality.
