//
//  PUDCloudPageInboxViewController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 7/1/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDCloudPageInboxViewController.h"

// Libraries
#import "ETLandingPagePresenter.h"
#import "ETMessage.h"
#import "PBWebViewController.h"

// Models
#import "PUDCloudPageInboxDataSource.h"

/**
 *  ET_NOTE: Notice that we specify a different data source than this controller (which is the typical way of implementing UITableViewControllers).
 */
@interface PUDCloudPageInboxViewController ()

/**
 *  ET_NOTE: this is our custom made data source class that inhereits from the ExactTargetEnhancedPushDataSource class
 */
@property (nonatomic, strong) PUDCloudPageInboxDataSource *dataSource;

@end

@implementation PUDCloudPageInboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     * ET_NOTE: instantiate the data source, set it to be our tableView's data source, then set the inbox tableview on our data source. It is important to call the setInboxTableView: method because the SDK will need to reload your tableview when a new cloud page is received
     */
    self.dataSource = [[PUDCloudPageInboxDataSource alloc] init];
    self.inboxTableView.dataSource = self.dataSource;
    [self.dataSource setInboxTableView:self.inboxTableView];
    
    if (!IOS_PRE_7_0) {
        self.inboxTableView.separatorInset = UIEdgeInsetsMake(0, 26, 0, 0);
        self.listFilterSegmentedControl.tintColor = [UIColor whiteColor];
    }
    
    // set up the segmented control
    self.segmentContainerView.backgroundColor = [UIColor colorWithRed:0.0/255.0
                                                                green:156.0/255.0
                                                                 blue:219.0/255.0
                                                                alpha:0.99];
    [self.listFilterSegmentedControl addTarget:self
                                        action:@selector(filterSegmentedControlDidChangeValue:)
                              forControlEvents:UIControlEventValueChanged];
}

#pragma mark - delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
     * ET_NOTE: Get the ETMessage object from the data source. Refer to the ETMessage.h file that is included in the SDK in order to see the available properties and methods
     */
    ETMessage *msg = [self.dataSource messageForRowAtIndexPath:indexPath];
    
    /*
     * ET_NOTE: This must be called on a message in order for it to be marked as read
     */
    [msg markAsRead];
    
    // use a custom view controller to display the web page
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = [msg siteURL];
    webViewController.showsNavigationToolbar = NO;
    
    [self.navigationController pushViewController:webViewController animated:YES];
    
    [self.inboxTableView reloadData];
}

#pragma mark - ui actions

- (void)filterSegmentedControlDidChangeValue:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == kPUDCloudPageFilterSegmentControlAllIndex) {
        [self.dataSource setCloudPageInboxFilter:kCloudPageInboxFilterAll];
    }
    else if (sender.selectedSegmentIndex == kPUDCloudPageFilterSegmentControlUnreadIndex) {
        [self.dataSource setCloudPageInboxFilter:kCloudPageInboxFilterUnread];
    }
    else if (sender.selectedSegmentIndex == kPUDCloudPageFilterSegmentControlReadIndex) {
        [self.dataSource setCloudPageInboxFilter:kCloudPageInboxFilterRead];
    }
    
    [self.inboxTableView reloadData];
}

@end
