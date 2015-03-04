/**
 * Copyright (c) 2014 ExactTarget, Inc.
 * All rights reserved.
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
    self.accessoryType = UITableViewCellAccessoryNone;
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
    
    else if (indexPath.section == kPUDSettingsActivitySectionIndex) {
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
