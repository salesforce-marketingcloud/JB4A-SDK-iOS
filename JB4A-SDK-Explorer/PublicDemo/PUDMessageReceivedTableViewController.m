/**
 * Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 * list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation and/or
 * other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its contributors
 * may be used to endorse or promote products derived from this software without
 * specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

//
//  PUDPushReceivedTableViewController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/12/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDMessageReceivedTableViewController.h"

// Controllers
#import "PUDDiscountTableViewController.h"
#import "PUDNavigationController.h"

@interface PUDMessageReceivedTableViewController ()

/**
 Stores the title of each section
 */
@property (nonatomic, strong) NSArray *sectionTitleArray;

/**
 Stores the footer of each section
 */
@property (nonatomic, strong) NSArray *sectionFooterArray;

/**
 Stores the strings that will be displayed in each row
 */
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation PUDMessageReceivedTableViewController

NSString *alertTextDefault = @"** No Alert Text Available **";
NSString *rawPayloadStringDefault = @"{\n\n}";
NSString *dateReceivedStringDefault = @"** No Date Available **";
NSString *messageTypeDefault = @"";

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _sectionTitleArray = @[@"Alert Text", @"Message Type", @"Payload"];
        
        _sectionFooterArray = @[@"The text that is displayed on the lock screen, banner, and alert views when a device receives the message.",
                                @"MobilePush allows you to send Location or Outbound messages.\n\nOutbound messages are sent through the Marketing Cloud or via a triggered send API. You can schedule an Outbound message to send immediately or at a future time.\n\nLocation messages are sent when a user crosses into or out of a geographical region. You can set separate messages for entry and exit inside the Marketing Cloud.",
                                @"This is the raw payload that the device receives from the Apple. This can be helpful for developers to see when debugging an app.\n\nNote: The _m custom key is always added to the payload by ExactTarget in order to provide message open tracking."];
        
        /**
         Set the default text that should be shown if there is no push text or raw payload
         */
        _dataArray = @[@[alertTextDefault], @[messageTypeDefault], @[rawPayloadStringDefault]];
        
        _shouldShowDiscountViewController = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self isModal]) {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    [self setupTableHeaderView];
    [self setupTableView];
    
    [self listeningForReceivedPushMessages];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kPUDUserDefaultsPushUserInfo];
    
    if (self.shouldShowDiscountViewController
        && [userInfo objectForKey:kPUDMessageDetailCustomKeyDiscountCode])
    {
        self.shouldShowDiscountViewController = NO;
        
        PUDDiscountTableViewController *discountViewController = [[UIStoryboard storyboardWithName:kPUDStoryboardMain bundle:nil] instantiateViewControllerWithIdentifier:kPUDStoryboardIdentifierDiscountCodeViewController];
        
        [self.navigationController pushViewController:discountViewController animated:YES];
    }
}

- (void)setupTableHeaderView {
    /**
     *  Create label with intro text
     */
    CGFloat xMargin = 15;
    CGFloat yMargin = 10;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(xMargin, yMargin, self.tableView.frame.size.width, 10)];
    label.numberOfLines = 0;
    label.text = @"This displays data for the last message that was 1) received while the app was active or 2) tapped by the user from inside notification center (whichever event happened most recently).";
    label.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.9];
    label.font = [UIFont systemFontOfSize:14.0];
    label.backgroundColor = [UIColor clearColor];
    
    CGSize maxSize = CGSizeMake(self.tableView.bounds.size.width - 30.0f, CGFLOAT_MAX);
    CGSize requiredSize = [label sizeThatFits:maxSize];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, requiredSize.width, requiredSize.height);
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, label.frame.size.height + yMargin)];
    [headerView addSubview:label];
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = self.dataArray[section];
    return rows.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionTitleArray[section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.sectionFooterArray[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPUDReuseIdentifierPushReceivedCell forIndexPath:indexPath];
    NSArray *rows = self.dataArray[indexPath.section];
    NSString *text = rows[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:kPUDAppCustomTextSize];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.text = text;
    cell.userInteractionEnabled = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rows = self.dataArray[indexPath.section];
    NSString *text = rows[indexPath.row];
    return [self textViewHeightForText:text];
}

#pragma mark - cell drawing

- (CGFloat)textViewHeightForText:(NSString *)text {
    /**
     There are better ways of doing this but for the demo's purpose it is fine to create a label everytime
     */
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:kPUDAppCustomTextSize];
    label.numberOfLines = 0;
    label.text = text;
    
    /**
     Subtract 30.0 here to account for padding
     */
    CGSize maxSize = CGSizeMake(self.tableView.bounds.size.width - 30.0f, CGFLOAT_MAX);
    CGSize requiredSize = [label sizeThatFits:maxSize];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, requiredSize.width, requiredSize.height);
    
    /**
     Add 20.0 here to account for padding
     */
    return label.frame.size.height + 28.0f;
}

#pragma mark - ui actions

- (IBAction)doneButtonTapped:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - other

- (void)setupTableView {
    
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kPUDUserDefaultsPushUserInfo];
    
    NSString *alertText = nil;
    NSString *payloadString = nil;
    NSString *dateReceivedString = nil;
    NSString *messageType = nil;
    
    /**
     Retrieve the alert text
     */
    alertText = [[NSUserDefaults standardUserDefaults] objectForKey:kPUDUserDefaultsAlertText];
    if (!alertText) {
        alertText = alertTextDefault;
    }
    
    /**
     Set the payload
     */
    payloadString = userInfo.description;
    if (!payloadString) {
        payloadString = rawPayloadStringDefault;
    }
    
    /**
     Set the received date
     */
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:kPUDUserDefaultsLastPushReceivedDate];
    if (date) {
        dateReceivedString = [date descriptionWithLocale:[NSLocale currentLocale]];
    }
    
    if (!date) {
        dateReceivedString = dateReceivedStringDefault;
    }
    
    /**
     *  Set the message type
     */
    messageType = [[NSUserDefaults standardUserDefaults] objectForKey:kPUDUserDefaultsMessageType];
    if (!messageType) {
        messageType = messageTypeDefault;
    }
    
    self.dataArray = @[@[alertText], @[messageType], @[payloadString]];
    [self.tableView reloadData];
}

- (BOOL)isModal {
    return self.presentingViewController.presentedViewController == self
    || self.navigationController.presentingViewController.presentedViewController == self.navigationController
    || [self.tabBarController.presentingViewController isKindOfClass:[UITabBarController class]];
}


# pragma mark - Custom Methods

// Registering as observer for receiving pushes
- (void) listeningForReceivedPushMessages {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView)
                                                 name:@"kPUDPushReceivedNotification"
                                               object:nil];
    
}

- (void) reloadView {
    /*
     This method makes sure the message details change whenever the Config chnages, even when the user is on this view
     */
    [self setupTableView];
    
    [self.tableView reloadData];
}
@end
