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
//  PUDSettingsTableData.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/11/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUDPreferencesTableData : NSObject

/**
 The text displayed in the textfield placeholder
 */
@property (nonatomic, strong) NSString *placeholderString;

/**
 The text displayed in the title label
 */
@property (nonatomic, strong) NSString *titleString;

/**
 The height of the cell in the table. If nil, the default value will be used
 */
@property (nonatomic, strong) NSNumber *cellHeight;

/**
 YES if the switch should be hidden, NO if it should be shown
 */
@property (nonatomic, strong) NSNumber *hideSwitch;

/**
 YES if the switch should be ON, NO if it should be OFF
 */
@property (nonatomic, strong) NSNumber *switchOnValue;

/**
 Current value of the cell's textfied
 */
@property (nonatomic, strong) NSString *textFieldValue;

/**
 The name of the sports team.
 */
@property (nonatomic, strong) NSString *teamName;

/**
 The name of the tag corresponding to the team.
 */
@property (nonatomic, strong) NSString *teamTag;

/**
 The block that will be called when a switch's value is changed
 */
@property (nonatomic, copy) SwitchValueChangedBlock switchValueChangedBlock;

/**
 Block that is called whenever the textfield is finished editing
 */
@property (nonatomic, copy) TextFieldDidEndEditingBlock textFieldDidEndEditingBlock;

@end
