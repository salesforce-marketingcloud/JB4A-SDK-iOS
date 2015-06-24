---
layout: page
title: "Custom Sound"
subtitle: "Specify Custom Notification Sound"
category: features
date: 2015-05-14 12:00:00
order: 7
---

To enable the use of custom audio for your <i>remote notifications<i/>, you will need to do the following:

1. Add a "custom.caf" file named exactly as it is written to your project. The cloud push payload will look for a file named "custom.caf" so make sure it is added.
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/audio_step1.png" /><br/>
<br/>
1. Then make sure the "custom.caf" audio file is added to the "Copy Bundle Resources" for your app. 
<br/>
 <img class="img-responsive" src="{{ site.baseurl }}/assets/audio_step2.png" /><br/>
<br/>
1. Make sure when you are sending a push message from the cloud that you specify the "Custom" option for sound. 

Important! When troublehooting and moving audio assets around, make sure you do a clean build folder in Xcode anytime you make changes to your audio file assets other wise they will often stick around and get cached. Go to product menu then hold option key down (Product > Clean Build Folder)