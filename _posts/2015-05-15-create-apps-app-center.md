---
layout: page
title: "Add App to App Center"
subtitle: "Create a MobilePush App in the App Center"
category: create-apps
date: 2015-05-14 12:00:00
order: 2
---
In order to connect your iOS app to the Marketing Cloud, you must first create a MobilePush app in the App Center. App Center represents the central development console for using Fuel APIs and building Marketing Cloud apps.

Each app in App Center represents an application connected to the Marketing Cloud. Developers familiar with connected apps in Force.com will find the concept of connected apps in the Marketing Cloud similar. App Center currently manages three types of connected apps:

* *API Integration* allows you to leverage the Marketing Cloud APIs. Create an API Integration app when you want to use Fuel APIs to automate tasks or integrate business systems. API Integration apps utilize an OAuth2 client credentials flow to acquire access tokens directly from the Fuel authentication service.
* *Marketing Cloud apps* represent apps located within the Marketing Cloud that launch via the Marketing Cloud app menu. Marketing Cloud apps include custom apps built by your organization or apps installed from the Marketing Cloud HubExchange. Marketing Cloud apps utilize a JSON Web Token (JWT) to acquire access tokens on behalf of logged-in users.
* *Application Extensions* allow you to extend the Marketing Cloud with custom Journey Builder activities, Cloud Editor Blocks, and Automation Studio activities.
* *MobilePush apps* represent apps built for the iOS or Android mobile platforms that use MobilePush to communicate with their users via push messages. The Marketing Cloud classifies MobilePush apps as consumer-grade applications and utilize long-lived limited access tokens.

<a href="https://appcenter-auth.exacttargetapps.com/create" target="_blank">Create an App Center account</a> if you do not currently own one.

Once you own an App Center account, <a href="https://appcenter-auth.exacttargetapps.com/redirect" target="_blank">log in to that account</a>. 

After you log into the App Center, follow these steps to create a new MobilePush app:

1. Create a new app and select the MobilePush template:

    <img class="img-responsive" src="{{ site.baseurl }}/assets/CreateNewApp05032016.png" />
1. Fill in, at a minimum, the mandatory fields in this form:

    <img class="img-responsive" src="{{ site.baseurl }}/assets/CreateNewMobilePushApp05032016.png" />
 
    > Repeat this process for Production and Development instances of your app.
    
    Note that following about required fields:
    
    * Use any value you wish for **Name**.
    * The **Package** value does not correllate to anything outside of the MarketingCloud ecosystem and can use **any** unique identifier for your application.
    * The **Description** and **MobilePush Icon** fields remain optional but will help you identify your application within your Marketing Cloud account.
    <br/><br/>
1. Click **Next** to integrate this new app with your Marketing Cloud account, as shown in [Integrate App Center App]({{ site.baseurl }}/create-apps/create-apps-marketing-cloud.html).
