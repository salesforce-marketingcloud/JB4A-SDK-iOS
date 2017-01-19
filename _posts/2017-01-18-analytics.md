---
layout: page
title: "Analytics"
subtitle: "Personalization Builder and Collect API Integration"
category: sdk-interfaces
date: 2017-01-18 12:00:00
order: 4
---
If Marketing Cloud analytics are enabled in the call to `sfmc_configureSDK...`, the application developer can take advantage of the methods described in `MarketingCloudSDK+Analytics.h`.

If you wish to implement Analytics, pass a YES value for the `analyticsEnabled` parameter. If you also wish to implement Web and Mobile Analytics, pass a YES value for the `piAnalyticsEnabled` parameter.

<script src="https://gist.github.com/sfmc-mobilepushsdk/3d9dad542bc2766de44c0a5b9739318b.js"></script>

The following methods integrate your mobile app with Personalization Builder. You must have an existing Personalization Builder deployment in order to use these. Also, you must enable the “PIAnalytics” option when you configure your SDK.

## Track Cart
Use to track the contents of an in-app shopping cart. For more information about this method’s general use with Personalization Builder, see [Track Items in Shopping Cart](http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_cart/). Sample code for use in your mobile app is below.

<script src="https://gist.github.com/sfmc-mobilepushsdk/7734ab26cff6d9f0cafb4d6a5e60f775.js"></script>

## Track Conversion
Use to track a purchase made through your mobile application. For more information about this method’s general use with Personalization Builder, see [Track Purchase Details](http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_conversion/). Sample code for use in your mobile app is below.

<script src="https://gist.github.com/sfmc-mobilepushsdk/92cfa9ab06448b24c1ac05a23448be5e.js"></script>

## Track Page View
Call the following method to implement page view analytics in your app. For more information about this method’s general use with Personalization Builder, see [Track Items Viewed](http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_page_view/). Sample code for use in your mobile app is below.

<script src="https://gist.github.com/sfmc-mobilepushsdk/ac68dd0f6cab46995f09a14013e08aa2.js"></script>


## Contact Key
Using Contact Key, you can link track cart, track conversion, and other Collect API analytic events with a specific user. Contact Key is included in the Collect API payload and can contain information such as email address, mobile number, device ID, etc. See `MarketingCloudSDK+ClientData.h` for more information.