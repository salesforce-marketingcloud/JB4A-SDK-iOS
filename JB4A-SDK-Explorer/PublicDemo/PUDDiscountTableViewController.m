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
//  PUDDiscountTableViewController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/19/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import "PUDDiscountTableViewController.h"

// Libraries
#import "ETPush.h"

// Models
#import "PUDDiscountTableData.h"

@interface PUDDiscountTableViewController ()

/**
 Stores the strings that will be displayed in each row
 */
@property (nonatomic, strong) NSArray *dataArray;

/**
 The userInfo dictionary that is passed to the AppDelegate when a push is received
 */
@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation PUDDiscountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     The user info variable should now be set. Reload the table view to display the data
     */
    [self reloadDiscountData];
}

#pragma mark - table data creation

- (void)reloadDiscountData {
    PUDDiscountTableData *message = [[PUDDiscountTableData alloc] init];
    
    PUDDiscountTableData *barcode = [[PUDDiscountTableData alloc] init];
    barcode.usesBarcodeFont = @(YES);
    barcode.cellHeight = @(160.0f);
    
    self.userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kPUDUserDefaultsPushUserInfo];
    
    if (self.userInfo) {
        /**
         Get the message from the payload
         */
        NSDictionary *apsDictionary = self.userInfo[@"aps"];
        if (apsDictionary) {
            message.titleString = apsDictionary[@"alert"];
        }
        
        /**
         ET_NOTE: Get the discount amount from the payload using the custom key value
         */
        NSString *discount = self.userInfo[kPUDMessageDetailCustomKeyDiscountCode];
        if (discount) {
            barcode.titleString = discount;
        }
    }
    
    self.dataArray = @[message, barcode];
    
    [self.tableView reloadData];
}

#pragma mark - table view data source methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PUDDiscountTableData *data = self.dataArray[indexPath.section];
    
    if (data.cellHeight) {
        return data.cellHeight.floatValue;
    }
    
    return [self textViewHeightForText:data.titleString];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPUDReuseIdentifierDiscountCell forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:kPUDAppCustomTextSize];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    PUDDiscountTableData *data = self.dataArray[indexPath.section];
    
    if (data.usesBarcodeFont && data.usesBarcodeFont.boolValue) {
        NSString *barcodeFontName;
        // IOS7 and IOS8 handle the font file fre3of9x.ttf differently
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
            // IOS >= 8 uses fontName "New" from font family name "New"
            barcodeFontName = @"New";
        else
            // IOS < 8 uses fontName "Free3of9Extended" from font family name "Free 3 of 9 Extended"
            barcodeFontName = kPUDAppBarcodeFont;
        
        cell.textLabel.font = [UIFont fontWithName:barcodeFontName size:150.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.textLabel.text = data.titleString;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    PUDDiscountTableData *data = self.dataArray[section];
    return data.sectionTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    PUDDiscountTableData *data = self.dataArray[section];
    return data.sectionFooter;
}

- (CGFloat)textViewHeightForText:(NSString *)text {
    /**
     There are better ways of doing this but for the demo's purpose it is fine to create a label everytime
     */
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:kPUDAppCustomTextSize];
    label.numberOfLines = 0;
    label.text = text;
    
    /**
     Subtract 30.0 here to account for padding
     */
    CGSize maxSize = CGSizeMake(self.tableView.bounds.size.width - 30.0f, CGFLOAT_MAX);
    CGSize requiredSize = [label sizeThatFits:maxSize];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, requiredSize.width, requiredSize.height);
    
    /**
     Add 28.0 here to account for padding
     */
    return label.frame.size.height + 28.0f;
}


@end
