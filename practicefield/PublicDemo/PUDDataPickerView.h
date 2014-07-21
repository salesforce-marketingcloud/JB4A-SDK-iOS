//
//  PUDDataPickerView.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/14/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PUDDataPickerView : UIPickerView

/**
 This array is used as the data source that is displayed as rows in the picker view
 */
@property (nonatomic, strong, readonly) NSArray *dataArray;

/**
 Block that is called whenever a picker view row value is changed
 */
@property (nonatomic, copy) PickerViewRowSelectedBlock pickerViewRowSelectedBlock;

- (id)initWithArray:(NSArray *)dataArray;

@end
