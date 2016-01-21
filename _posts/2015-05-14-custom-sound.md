---
layout: page
title: "Custom Sound"
subtitle: "Specify Custom Notification Sound"
category: features
date: 2015-05-14 12:00:00
order: 7
---

To enable the use of custom audio for your <i>remote notifications<i/>, implement the following steps:

1. Add a **custom.caf** file (label it exactly as written) to your project. The cloud push payload will look for a file named **custom.caf**.
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/audio_step1.png" /><br/>
<br/>
1. Add the "custom.caf" audio file to the **Copy Bundle Resources** for your app. 
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/audio_step2.png" /><br/>
<br/>
1. Specify the **Custom** option for sound when you sendi a push message from the Marketing Cloud user interface. 

> When troublehooting and moving audio assets around, make sure you perform a clean build folder in Xcode anytime you make changes to your audio file assets. Otherwise, Xcode may used cached files. Navigate to the Product menu, then hold option key down and select **Clean Builder Folder**.