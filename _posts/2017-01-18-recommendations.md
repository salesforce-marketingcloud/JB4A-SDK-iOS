---
layout: page
title: "Recommendations"
subtitle: "Web and Mobile Analytics Recommendations"
category: sdk-interfaces
date: 2017-01-18 12:00:00
order: 5
---
If Marketing Cloud analytics are enabled in the call to `sfmc_configureSDK...`, the application developer can take advantage of the methods described in `MarketingCloudSDK+Recommendations.h`.

If you also wish to implement Web and Mobile Analytics for recommendations, pass a YES value for the `piAnalyticsEnabled` parameter.

<script src="https://gist.github.com/sfmc-mobilepushsdk/3d9dad542bc2766de44c0a5b9739318b.js"></script>

Using your configuration-specific `mid` value, call request recommendations like this:

<script src="https://gist.github.com/sfmc-mobilepushsdk/fc9bd2422696c178fdd21fd6007dff2c.js"></script>

For more information, see `MarketingCloudSDK+Recommendations.h`