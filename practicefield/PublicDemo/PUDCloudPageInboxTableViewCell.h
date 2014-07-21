//
//  PUDCloudPagesInboxTableViewCell.h
//  PublicDemo
//
//  Created by Matt Lathrop on 7/8/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETMessage;

@interface PUDCloudPageInboxTableViewCell : UITableViewCell

/*
 * Diplays the subject of the message
 */
@property (nonatomic, weak) IBOutlet UILabel *messageTitleLabel;

/*
 * Displays the start date of the message
 */
@property (nonatomic, weak) IBOutlet UILabel *messageStartDateLabel;

/*
 * Configures all of the cells views using the data in the message
 */
- (void)configureWithMessage:(ETMessage *)message atIndexPath:(NSIndexPath *)indexPath;

@end
