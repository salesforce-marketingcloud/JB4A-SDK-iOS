//
//  PUDPushReceivedTableViewController.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/12/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PUDMessageReceivedTableViewController : UITableViewController

/**
 YES if the discount view controller should be pushed onto the navigation stack, NO to only display the Push Received view controller
 */
@property (nonatomic) BOOL shouldShowDiscountViewController;

@end
