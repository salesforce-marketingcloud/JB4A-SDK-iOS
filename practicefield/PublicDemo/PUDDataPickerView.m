//
//  PUDDataPickerView.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/14/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDDataPickerView.h"

@interface PUDDataPickerView()

@property (nonatomic, strong, readwrite) NSArray *dataArray;

@end

@implementation PUDDataPickerView

- (id)initWithArray:(NSArray *)dataArray
{
    self = [super init];
    if (self) {
        _dataArray = dataArray;
    }
    return self;
}

@end
