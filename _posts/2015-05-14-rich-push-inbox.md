---
layout: page
title: "Inbox"
subtitle: "Cloud Page Inbox"
category: rich-push
date: 2015-05-14 12:00:00
order: 3
---
For CloudPage-only Messages, the JB4A SDK will download new messages each time your app comes into the foreground.

Your app must be configured to display these messages. The SDK provides an interface for you to use to allow your customers to view CloudPage-only messages sent from the Salesforce Marketing Cloud directly to the app. The inbox in the app displays these messages, and the app displays no alert for these messages.

~~~ 
    /*
     * ET_NOTE: instantiate the data source, set it to be our tableView's data source, then set the inbox tableview on our data source. It is important to call the setInboxTableView: method because the SDK will need to reload your tableview when a new cloud page is received
     */
    self.dataSource = [[PUDCloudPageInboxDataSource alloc] init];
    self.inboxTableView.dataSource = self.dataSource;
    [self.dataSource setInboxTableView:self.inboxTableView];
~~~ 

Review the <a href="https://github.com/ExactTarget/JB4A-SDK-iOS/tree/master/JB4A-SDK-Explorer" target="_blank">Journey Builder for Apps iOS SDK Explorer</a> within the Journey Builder for Apps iOS SDK public GitHub repository. The app provides a full sample of a CloudPage Inbox within the PUDCloudPageInboxViewController.