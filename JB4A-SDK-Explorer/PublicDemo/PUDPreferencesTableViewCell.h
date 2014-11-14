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
