//
//  PUDCloudPageInboxViewController.h
//  PublicDemo
//
//  Created by Matt Lathrop on 7/1/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  ET_NOTE: This controller is responsible for displaying the CloudPage Inbox. This is an example of implementing a CloudPage Inbox inside your own app. Note that we use a UIViewController with a tableview embedded in it's view as opposed to using a UITableViewController in order to show the toolbar at the top of the view that has the "All, Unread, Read" filter. If you don't plan on supporting a filter inside your app then you will be fine using a UITableViewController.
 */
@interface PUDCloudPageInboxViewController : UIViewController <UITableViewDelegate>

/**
 *  The table view that will display the cloudpages
 */
@property (nonatomic, strong) IBOutlet UITableView *inboxTableView;

/**
 *  The view that contains the list filter segmented control
 */
@property (weak, nonatomic) IBOutlet UIView *segmentContainerView;

/**
 *  The segmented control that will allow the user to filter the table on all, read, or unread
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *listFilterSegmentedControl;

@end
