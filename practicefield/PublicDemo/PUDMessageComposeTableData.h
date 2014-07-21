//
//  PUDMessageComposerData.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/14/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PUDDataPickerView;

@interface PUDMessageComposeTableData : NSObject

/**
 The text of the table view section title
 */
@property (nonatomic, strong) NSString *sectionTitle;

/**
 The text of the table view section footer
 */
@property (nonatomic, strong) NSString *sectionFooter;

/**
 Stores the currently selected picker view row index
 */
@property (nonatomic) NSInteger pickerSelectedRowIndex;

/**
 Block that is called that returns a CGFloat of the cell's height
 */
@property (nonatomic, copy) CellHeightBlock cellHeightBlock;

/**
 Block that is called that is responsible for setting up the cell's ui controls
 */
@property (nonatomic, copy) ConfigureCellBlock configureCellBlock;

/**
 Block that is called whenever the textfield is finished editing
 */
@property (nonatomic, copy) TextFieldDidEndEditingBlock textFieldDidEndEditingBlock;

/**
 The block that will be called when a switch's value is changed
 */
@property (nonatomic, copy) SwitchValueChangedBlock switchValueChangedBlock;

/**
 The block that will be called when a segment control's value is changed
 */
@property (nonatomic, copy) SegmentedControlerValueChangedBlock segmentedControlValueChangedBlock;

@end
