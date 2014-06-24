//
//  PUDSettingsTableViewCell.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/11/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

// Models
@class PUDPreferencesTableData;

@interface PUDPreferencesTableViewCell : UITableViewCell

/**
 Allows user to set attribute values for current device
 */
@property (nonatomic, strong) IBOutlet UITextField *attributeTextField;

/**
 Displays title of current setting
 */
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

/**
 Displays detail info on the current settings
 */
@property (nonatomic, strong) IBOutlet UILabel *detailLabel;

/**
 Allows user to turn notifications on or off
 */
@property (nonatomic, strong) IBOutlet UISwitch *notificationSwitch;

/**
 Sets up the cell view using the data present in the PUDSettingsTableData object
 
 @param data The PUDSettingsTableData containing the data that should be displayed in the cell.
 @param indexPath The indexPath of the cell that is being configured.
 */
- (void)configureWithData:(PUDPreferencesTableData *)data atIndexPath:(NSIndexPath *)indexPath;

@end
