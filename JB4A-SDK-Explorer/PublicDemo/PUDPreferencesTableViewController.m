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
//  PUDSettingsTableViewController.m
//  PushDemo
//
//  Created by Matt Lathrop on 4/30/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDPreferencesTableViewController.h"

// Libraries
#import "ETPush.h"

// Models
#import "PUDPreferencesTableData.h"

// Views
#import "PUDPreferencesTableViewCell.h"
#import "PUDPushConfigTableViewController.h"

//Constants
#import "PUDConstants.h"

@interface PUDPreferencesTableViewController ()

@property (nonatomic, assign) id currentResponder;

/**
 Stores the strings that will be displayed in each row
 */
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign, getter = isUpdateETRequired) BOOL updateETRequired;

@end

@implementation PUDPreferencesTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //  _dataArray = @[[self currentPushConfig],[self personalInformationData], [self footballTagsData], [self soccerTagsData]];
        _updateETRequired = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignOnTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap setNumberOfTouchesRequired:1];
    singleTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:singleTap];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    _dataArray = @[[self personalInformationData], [self activityTagsData]];

    // show alert about 15 min processing time
    [[[UIAlertView alloc] initWithTitle:@"Updating Preferences"
                                message:@"Updates to preferences can take up to 15 mins to be processed. Before sending a message, wait 15 mins for changes to take effect."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    
    [self.tableView reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    /**
     ET_NOTE: updateET should be called as SPARINGLY as possible. A good place to call this is whenever a user exits out of your settings screen where he or she can edit values that are used as contact attributes. This method will then send the attribute changes to ExactTarget
     */
    if (self.isUpdateETRequired) {
        self.updateETRequired = NO;
        [[ETPush pushManager] updateET];
    }
}

#pragma mark - table data creation

- (NSArray *)personalInformationData {
    
    PUDPreferencesTableData *firstName = [[PUDPreferencesTableData alloc] init];
    firstName.placeholderString = @"First Name";
    firstName.textFieldValue = [[NSUserDefaults standardUserDefaults] stringForKey:kPUDUserDefaultsFirstName];
    
    __weak PUDPreferencesTableData *weakFirstName = firstName;
    firstName.textFieldDidEndEditingBlock = ^(UITextField *textField) {
        self.updateETRequired = YES;
        
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kPUDUserDefaultsFirstName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        /**
         *  ET_NOTE: add an attribute named FirstName for this device. This attribute should first be defined inside MobilePush before being used inside the SDK
         */
        [[ETPush pushManager] addAttributeNamed:kPUDAttributeFirstName value:textField.text];
        weakFirstName.textFieldValue = textField.text;
    };
    
    PUDPreferencesTableData *lastName = [[PUDPreferencesTableData alloc] init];
    lastName.placeholderString = @"Last Name";
    lastName.textFieldValue = [[NSUserDefaults standardUserDefaults] stringForKey:kPUDUserDefaultsLastName];
    
    __weak PUDPreferencesTableData *weakLastName = lastName;
    lastName.textFieldDidEndEditingBlock = ^(UITextField *textField) {
        self.updateETRequired = YES;
        
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:kPUDUserDefaultsLastName];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        /**
         *  ET_NOTE: add an attribute named LastName for this device. This attribute should first be defined inside MobilePush before being used inside the SDK
         */
        [[ETPush pushManager] addAttributeNamed:kPUDAttributeLastName value:textField.text];
        weakLastName.textFieldValue = textField.text;
    };
    
    return @[firstName, lastName];
}

- (NSArray *)activityTagsData {
    
    PUDPreferencesTableData *campingGear = [[PUDPreferencesTableData alloc] init];
    campingGear.teamName = @"Camping Gear";
    campingGear.teamTag = @"camping gear";
    campingGear.hideSwitch = @(NO);
    campingGear.titleString = campingGear.teamName;
    campingGear.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *hikingSupplies = [[PUDPreferencesTableData alloc] init];
    hikingSupplies.teamName = @"Hiking Supplies";
    hikingSupplies.teamTag = @"hiking supplies";
    hikingSupplies.hideSwitch = @(NO);
    hikingSupplies.titleString = hikingSupplies.teamName;
    hikingSupplies.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *boatingGear = [[PUDPreferencesTableData alloc] init];
    boatingGear.teamName = @"Boating Gear";
    boatingGear.teamTag = @"boating gear";
    boatingGear.hideSwitch = @(NO);
    boatingGear.titleString = boatingGear.teamName;
    boatingGear.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *fishingSupplies = [[PUDPreferencesTableData alloc] init];
    fishingSupplies.teamName = @"Fishing Supplies";
    fishingSupplies.teamTag = @"fishing supplies";
    fishingSupplies.hideSwitch = @(NO);
    fishingSupplies.titleString = fishingSupplies.teamName;
    fishingSupplies.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *huntingGear = [[PUDPreferencesTableData alloc] init];
    huntingGear.teamName = @"Hunting Gear";
    huntingGear.teamTag = @"hunting gear";
    huntingGear.hideSwitch = @(NO);
    huntingGear.titleString = huntingGear.teamName;
    huntingGear.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    return @[campingGear, hikingSupplies, boatingGear, fishingSupplies,huntingGear];
}

#pragma mark - table view data source methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *rows = self.dataArray[indexPath.section];
    PUDPreferencesTableData *data = rows[indexPath.row];
    
    if (data.cellHeight) {
        return data.cellHeight.floatValue;
    }
    
    return 44.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *rows = self.dataArray[section];
    return rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PUDPreferencesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPUDReuseIdentifierSettingCell forIndexPath:indexPath];
    NSArray *rows = self.dataArray[indexPath.section];
    PUDPreferencesTableData *data = rows[indexPath.row];
    [cell configureWithData:data atIndexPath:indexPath];
    cell.attributeTextField.delegate = self;
    [cell.notificationSwitch addTarget:self action:@selector(switchValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == kPUDSettingsPersonalInformationSectionIndex) {
        return @"Attributes";
    }
    else if (section == kPUDSettingsActivitySectionIndex) {
        return @"Activity Tags";
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    if (section == kPUDSettingsPersonalInformationSectionIndex) {
        return @"Attributes contain specific information about your subscribers such as first and last name, gender, and geographical location.\n\nYou can assign specific information as part of a subscriber attribute to be used as part of sends or subscriber management.\n\nThis app stores first name and last name as attributes.";
    }
    
    else if (section == kPUDSettingsActivitySectionIndex) {
        return @"Tags are used to specify which messsages a customer wishes to receive. For example, to receive messages for an interest in a particular activity.\n\n";
    }
    
    return nil;
}

#pragma mark - ui actions

- (void)switchValueDidChange:(UISwitch *)sender {
    /**
     Get data object corresponding to the switch
     */
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    NSArray *rows = self.dataArray[indexPath.section];
    PUDPreferencesTableData *data = rows[indexPath.row];
    
    if (data.switchValueChangedBlock) {
        data.switchValueChangedBlock(sender);
    }
}

- (void)valueChangedForTagSwitch:(UISwitch *)tagSwitch {
    
    /**
     Post a notification for changed Preferences
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUDPreferencesChanged
                                                        object:self
                                                      userInfo:nil];

    /**
     Get data object corresponding to the switch
     */
    CGPoint buttonPosition = [tagSwitch convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    NSArray *rows = self.dataArray[indexPath.section];
    PUDPreferencesTableData *data = rows[indexPath.row];
    
    /**
     *  ET_NOTE: add or remove tags for the current device. Tags don't have to be defined inside of MobilePush before using them. You can create them at will
     */
    if (tagSwitch.on) {
        [[ETPush pushManager] addTag:data.teamTag];
    }
    else {
        [[ETPush pushManager] removeTag:data.teamTag];
    }
    
    self.updateETRequired = YES;
}

#pragma mark - text view delegate methods

- (void)resignOnTap:(id)iSender {
    [self.currentResponder resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentResponder = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    /**
     Get data object corresponding to the switch
     */
    CGPoint buttonPosition = [textField convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    NSArray *rows = self.dataArray[indexPath.section];
    PUDPreferencesTableData *data = rows[indexPath.row];
    
    if (data.textFieldDidEndEditingBlock) {
        data.textFieldDidEndEditingBlock(textField);
    }
    
    /**
     Post a notification for changed Preferences
     */
    [[NSNotificationCenter defaultCenter] postNotificationName:kPUDPreferencesChanged
                                                        object:self
                                                      userInfo:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
