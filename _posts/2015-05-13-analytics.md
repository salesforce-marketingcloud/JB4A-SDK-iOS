---
layout: page
title: "Analytics"
subtitle: "Adding Analytics"
category: features
date: 2015-05-14 12:00:00
order: 6
---
Follow the steps below to implement ET and/or Mobile analytics in your mobile app:

ET Analytics

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

1. To see your new Web and Mobile Analytics, open the Web and Mobile Analytics app within the Marketing Cloud: 
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/wama_menu.png" /><br/>
<br/>

1. Then check the checkbox agreeing to the Terms and Conditions to get started:
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/wama_t_and_c.png" /><br/>
<br/>