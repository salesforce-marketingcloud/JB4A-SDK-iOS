---
layout: page
title: "Add App to App Center"
subtitle: "Create a MobilePush App in the App Center"
category: create-apps
date: 2015-05-14 12:00:00
order: 2
---
In order to connect your iOS app to the Marketing Cloud, you must first create a MobilePush app in the App Center.  App Center is the central development console for using Fuel’s APIs and building Marketing Cloud apps.

Each app in App Center represents an application connected to the Marketing Cloud. If you are familiar with connected apps in Force.com, you will find the concept of connected apps in the Marketing Cloud familiar. App Center currently manages three types of connected apps:

* *API Integration* allow you to leverage the Marketing Cloud APIs. Create an API Integration app when you want to use Fuel APIs to automate tasks or integrate business systems. API Integration apps utilize an OAuth2 client credentials flow to acquire access tokens directly from the Fuel authentication service.
* *Marketing Cloud apps* represent apps that live within the Salesforce Marketing Cloud and launch via the Marketing Cloud app menu. Marketing Cloud apps include custom apps built by your organization or apps installed from the Salesforce Marketing Cloud HubExchange. Marketing Cloud apps utilize a JSON Web Token (JWT) to acquire access tokens on behalf of logged in users.
* *Application Extensions* allow you to extend the Marketing Cloud with custom Journey Builder activities, Cloud Editor Blocks, and Automation Studio activities.
* *MobilePush apps* represent apps built for the iOS, Android, or Blackberry mobile platforms that use MobilePush to communicate with their users via push messages. The Salesforce Marketing Cloud classifies MobilePush apps as consumer-grade applications and utilize long-lived limited access tokens.

If you haven't already, you should <a href="https://appcenter-auth.exacttargetapps.com/create" target="_blank">create an App Center account</a>.

If you have an App Center account, you can <a href="https://appcenter-auth.exacttargetapps.com/redirect" target="_blank">log in to that account</a>. 

After you have logged in to the App Center, follow these steps in order to create a new MobilePush app:

1.  Create a new app and select the MobilePush template:

    <img class="img-responsive" src="{{ site.baseurl }}/assets/CreateNewApp.png" />
2.  Fill in, at a minimum, the mandatory fields in this form:

    <img class="img-responsive" src="{{ site.baseurl }}/assets/CreateNewMobilePushApp.png" />
 
    > You must repeat this process for Production and Development instances of your app.
    
    Note that following about the required fields:
    
    * The **Name** can be anything you choose.
    * The **Package** has no correlation to anything outside of the MarketingCloud ecosystem and can be **any** unique identifier for your application.
    * The **Description** & **MobilePush Icon** fields are optional but will help you identify your application within your Marketing Cloud account.
    <br/><br/>
3.  Click **Next** in order to integrate this new app with your Marketing Cloud account as shown in [Integrate App Center App]({{ site.baseurl }}/create-apps/create-apps-marketing-cloud.html).
