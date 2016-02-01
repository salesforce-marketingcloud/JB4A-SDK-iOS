---
layout: page
title: "Analytics"
subtitle: "Adding Analytics"
category: features
date: 2015-05-14 12:00:00
order: 6
---
Follow the steps on this page to implement ETAnalytics and Web and Mobile analytics in your mobile app:

###ET Analytics

If you wish to implement ETAnalytics for analytical information on your app, pass a YES value for the withAnalytics parameter.

~~~ 
    successful = [[ETPush pushManager] configureSDKWithAppID:kETAppID_Debug
                                              andAccessToken:kETAccessToken_Debug
                                               withAnalytics:YES
                                         andLocationServices:NO
                                               andCloudPages:NO
                                             withPIAnalytics:YES
                                                       error:&error];
~~~ 

###Web and Mobile Analytics

1. To see your new Web and Mobile Analytics information, open the [Web and Mobile Analytics](http://www.exacttarget.com/products/customer-data-platform/web-mobile-analytics){:target="_blank"} app within the Marketing Cloud: 
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/wama_menu.png" /><br/>
<br/>

1. Then check the checkbox agreeing to the Terms and Conditions to get started:
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/wama_t_and_c.png" /><br/>
<br/>

###Track Page View

Call the following method to implement page view analytics in your capp.

~~~
+ (void)trackPageView:(NSString *)url andTitle:(NSString *)title andItem:(NSString *)item andSearch:(NSString *)search
~~~

* **url** - a non-nil NSSstring identifying the location within your app visited by a user
* **title** - a NSString identifying the title of the location within your app visited by a user (can contain a nil value)
* **item** - a NSString identifying an item viewed by a user (such as UPC-1234, can contain a nil value)
* **search** - a NSString identifying search terms used by a user (such as **blue jeans**, can contain a nil value)