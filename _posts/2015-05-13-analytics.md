---
layout: page
title: "Analytics"
subtitle: "Adding Analytics"
category: features
date: 2015-05-14 12:00:00
order: 6
---
Follow the steps on this page to implement Analytics and Web and Mobile analytics in your mobile app:

### Analytics

If you wish to implement Analytics, pass a YES value for the withAnalytics parameter.  If you also wish to implement Web and Mobile Analytics, pass a YES value for the withPIAnalytics parameter.

<script src="https://gist.github.com/sfmc-mobilepushsdk/57757242e4d76abee281.js"></script>

### Web and Mobile Analytics

#### Track Cart
Use to track the contents of an in-app shopping cart.

<script src="https://gist.github.com/sfmc-mobilepushsdk/5c21e497878b8d51ccb81cc4694b99fa"></script>

#### Track Conversion
Use to track a purchase made through your mobile application.

<script src=https://gist.github.com/sfmc-mobilepushsdk/5e942a1125b7f45fd16b6e01290df510"></script>
  
#### Track Page View
Call the following method to implement page view analytics in your app.  These analytics are sent to the Web and Mobile Analytics app in the Marketing Cloud.

<script src="https://gist.github.com/sfmc-mobilepushsdk/97625936a95fa46a0e8a.js"></script>

As well as providing the ability to track page views within your app, the Web and Mobile Analytics app will provide information about the time your customers are spending in your app.  To view this information in the Web and Mobile App, following these steps to configure the Web and Mobile Analytic app within your Marketing Cloud account.

1. 	To see your new Web and Mobile Analytics information sent by the SDK, open the [Web and Mobile Analytics](http://www.exacttarget.com/products/customer-data-platform/web-mobile-analytics){:target="_blank"} app within the Marketing Cloud: 
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/wama_menu.png" /><br/>
<br/><br/>

1. 	Then check the checkbox agreeing to the Terms and Conditions to get started:
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/wama_t_and_c.png" /><br/>
<br/>
