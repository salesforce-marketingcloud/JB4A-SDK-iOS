---
layout: page
title: "Custom Keys"
subtitle: "Handling Custom Keys Sent with Message Payload"
category: features
date: 2015-05-14 12:00:00
order: 5
---

Use custom keys to send extra data along with a push notification. You can use custom keys to add tracking or additional functionality to your app. For example, you can define a custom key that allows a third-party application to provide custom tracking information regarding customer usage on your mobile app. This data can include an ID value used by the app to retrieve additional data or other function. You must [enable](http://help.exacttarget.com/en/documentation/mobilepush/administering_your_mobilepush_account/apps_and_optional_settings_in_your_mobilepush_account/#customkeys) this feature in the Marketing Cloud application.

<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/CustomKeys.png" /><br/>
<br/>

To process custom keys when a push message arrives while the app is in the foreground, use code like the sample below and iOS will call your delegate:

~~~
    -(void)application:(UIApplication )application
    didReceiveRemoteNotification:(NSDictionary )userInfo
    {
         [[ETPush pushManager] handleNotification:userInfo
         forApplicationState:application.applicationState];
         NSString eventId = [userInfo objectForKey:@"eventId"];
         //Add custom code here… launch a special view controller, etc…
    }

~~~

To process custom keys when a push message arrives while the app is in the background, retrieve the custom keys in the didFinishLaunchingWithOptions method with code like the sample below:

~~~
    -(BOOL)application:(UIApplication)application
    didFinishLaunchingWithOptions:(NSDictionary )launchOptions {
         …
         [[ETPush pushManager] shouldDisplayAlertViewIfPushReceived:YES];
         [[ETPush pushManager] applicationLaunchedWithOptions:launchOptions];
         …
         if (launchOptions != nil) {
              // Launched from push notification
              NSDictionary userInfo = [launchOptions
              objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
              NSString *eventId = [userInfo objectForKey:@"eventId"];
              //Add custom code here…
         }
    }

~~~