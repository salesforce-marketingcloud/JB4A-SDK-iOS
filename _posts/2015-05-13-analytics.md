---
layout: page
title: "Analytics"
subtitle: "Adding Analytics"
category: features
date: 2015-05-14 12:00:00
order: 6
---
Follow the steps on this page to implement Analytics and Web and Mobile analytics in your mobile app.

## Analytics

If you wish to implement Analytics, pass a YES value for the withAnalytics parameter.  If you also wish to implement Web and Mobile Analytics, pass a YES value for the withPIAnalytics parameter.

<script src="https://gist.github.com/sfmc-mobilepushsdk/57757242e4d76abee281.js"></script>
<div id="TrackCartAnalytics"></div> 

## Personalization Builder and Collect API Integration


The following methods integrate your mobile app with Personalization Builder. You must have an existing Personalization Builder deployment in order to use these. Also, you must enable the "PIAnalytics" option when you configure your SDK.

### Track Cart

Use to track the contents of an in-app shopping cart. For more information about this method's general use with Personalization Builder, see <a href="http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_cart/" target="_blank">Track Items in Shopping Cart</a>. Sample code for use in your mobile app is below.

<script src="https://gist.github.com/sfmc-mobilepushsdk/d8bb05166f37dabc5780763a4a39bb31.js"></script>

### Track Conversion

Use to track a purchase made through your mobile application. For more information about this method's general use with Personalization Builder, see <a href="http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_conversion/" target="_blank">Track Purchase Details</a>. Sample code for use in your mobile app is below.

<script src="https://gist.github.com/sfmc-mobilepushsdk/23d224f8bb3e4dc510c356755dbd323d.js"></script>
  
### Track Page View
Call the following method to implement page view analytics in your app. For more information about this method's general use with Personalization Builder, see <a href="http://help.marketingcloud.com/en/documentation/collect_code/install_collect_code/track_page_view/" target="_blank">Track Items Viewed</a>. Sample code for use in your mobile app is below.

<script src="https://gist.github.com/sfmc-mobilepushsdk/97625936a95fa46a0e8a.js"></script>

### Subscriber Key

Using Subscriber Key, you can link track cart, track conversion, and other Collect API analytic events with a specific user. Subscriber Key is included in the Collect API payload and can contain information such as email addess, mobile number, customer number, etc. See [Updating Subscriber Key]({{ site.baseurl }}/features/subscriber-key.html) for more information.

## Access Web & Mobile Analytics

As well as providing the ability to track page views within your app, the Web and Mobile Analytics app will provide information about the time your customers are spending in your app.  To view this information in the Web and Mobile App, following these steps to configure the Web and Mobile Analytic app within your Marketing Cloud account.

1. 	To see your new Web and Mobile Analytics information sent by the SDK, open the [Web and Mobile Analytics](http://www.exacttarget.com/products/customer-data-platform/web-mobile-analytics){:target="_blank"} app within the Marketing Cloud: 
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/wama_menu.png" /><br/>
<br/><br/>

1. 	Then check the checkbox agreeing to the Terms and Conditions to get started:
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/wama_t_and_c.png" /><br/>
<br/>
