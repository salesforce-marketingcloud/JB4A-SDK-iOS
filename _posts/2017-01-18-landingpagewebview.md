---
layout: page
title: "Landing Page Webview"
subtitle: "Landing Page Webview"
category: sdk-interfaces
date: 2017-01-18 12:00:00
order: 8
---
MarketingCloudSDK supports a simple view controller to display a web view. Typically, this view controller is used in conjunction with a CloudPage "inbox" display (see `MarketingCloudSDK+CloudPage.h` for information about `MarketingCloudSDKCloudPageDataSource`). 

To utilize this view controller, create an instance of a landing page and display it from the parent view controller using a URL as a NSString or NSURL parameter.

<script src="https://gist.github.com/sfmc-mobilepushsdk/73dd5ae78b5c6373ae8a2e88bc1299cf.js"></script>

See `MarketingCloudSDK+LandingPage.h` for more information.
