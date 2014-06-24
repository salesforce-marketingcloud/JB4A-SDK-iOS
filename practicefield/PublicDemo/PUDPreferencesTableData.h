//
//  PUDSettingsTableData.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/11/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
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
