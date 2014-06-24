//
//  PUDSettingsTableViewCell.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/11/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDPreferencesTableViewCell.h"

// Libraries
#import "ETPush.h"

// Models
#import "PUDPreferencesTableData.h"

@implementation PUDPreferencesTableViewCell

- (void)configureWithData:(PUDPreferencesTableData *)data atIndexPath:(NSIndexPath *)indexPath {
    /**
     Cell defaults
     */
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.notificationSwitch.hidden = YES;
    self.notificationSwitch.on = NO;
    self.titleLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    
    /**
     Show/Hide switch depending on data
     */
    if (data.hideSwitch) {
        self.notificationSwitch.hidden = data.hideSwitch.boolValue;
    }
    
    /**
     Set the switch to the correct value
     */
    if (data.switchOnValue) {
        self.notificationSwitch.on = data.switchOnValue.boolValue;
    }
    
    /**
     Set up cell according to PUDSettingsTableData
     */
    if (indexPath.section == kPUDSettingsPersonalInformationSectionIndex) {
        self.attributeTextField.hidden = NO;
        self.titleLabel.hidden = YES;
        self.detailLabel.hidden = YES;
        
        self.attributeTextField.placeholder = data.placeholderString;
        self.attributeTextField.text = data.textFieldValue;
    }
    else if (indexPath.section == kPUDSettingsFootballSectionIndex || indexPath.section == kPUDSettingsSoccerSectionIndex) {
        self.attributeTextField.hidden = YES;
        self.titleLabel.hidden = NO;
        self.detailLabel.hidden = NO;
        
        /**
         ET_NOTE: Set the switch to ON or OFF depending on whether or not a tag is present in allTags. An alternative to this would be to keep track of what Tags are ON yourself using NSUSerDefaults as an example
         */
        NSSet *tagSet = [[ETPush pushManager] allTags];
        if ([tagSet containsObject:data.teamTag]) {
            self.notificationSwitch.on = YES;
        }
        else {
            self.notificationSwitch.on = NO;
        }
        
        self.titleLabel.font = [UIFont systemFontOfSize:17.0];
        self.detailLabel.text = nil;
        self.titleLabel.text = data.titleString;
        self.detailLabel.textColor = [UIColor darkGrayColor];
    }
}

@end
