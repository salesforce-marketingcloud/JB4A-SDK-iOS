//
//  PUDDiscountTableData.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/19/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PUDDiscountTableData : NSObject

/**
 The text displayed in the title label
 */
@property (nonatomic, strong) NSString *titleString;

/**
 The text of the table view section header
 */
@property (nonatomic, strong) NSString *sectionTitle;

/**
 The text of the table view section footer
 */
@property (nonatomic, strong) NSString *sectionFooter;

/**
 YES if the barcode font is used on the cell's text label, NO if the defaut font should be used
 */
@property (nonatomic, strong) NSNumber *usesBarcodeFont;

/**
 The height of the cell as displayed in the table
 */
@property (nonatomic, strong) NSNumber *cellHeight;

@end
