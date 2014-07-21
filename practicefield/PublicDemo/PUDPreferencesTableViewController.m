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
        _dataArray = @[[self personalInformationData], [self footballTagsData], [self soccerTagsData]];
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
    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // show alert about 15 min processing time
    [[[UIAlertView alloc] initWithTitle:@"Updating Preferences"
                                message:@"Updates to preferences can take up to 15 mins to be processed. Before sending a message, wait 15 mins for changes to take effect."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
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

- (NSArray *)footballTagsData {
    PUDPreferencesTableData *dallasCowboys = [[PUDPreferencesTableData alloc] init];
    dallasCowboys.teamName = @"Dallas Cowboys";
    dallasCowboys.teamTag = @"cowboys";
    dallasCowboys.hideSwitch = @(NO);
    dallasCowboys.titleString = dallasCowboys.teamName;
    dallasCowboys.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *greenBayPackers = [[PUDPreferencesTableData alloc] init];
    greenBayPackers.teamName = @"Green Bay Packers";
    greenBayPackers.teamTag = @"packers";
    greenBayPackers.hideSwitch = @(NO);
    greenBayPackers.titleString = greenBayPackers.teamName;
    greenBayPackers.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *newYorkGiants = [[PUDPreferencesTableData alloc] init];
    newYorkGiants.teamName = @"New York Giants";
    newYorkGiants.teamTag = @"giants";
    newYorkGiants.hideSwitch = @(NO);
    newYorkGiants.titleString = newYorkGiants.teamName;
    newYorkGiants.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *pittsburghSteelers = [[PUDPreferencesTableData alloc] init];
    pittsburghSteelers.teamName = @"Pittsburgh Steelers";
    pittsburghSteelers.teamTag = @"steelers";
    pittsburghSteelers.hideSwitch = @(NO);
    pittsburghSteelers.titleString = pittsburghSteelers.teamName;
    pittsburghSteelers.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *indianapolisColts = [[PUDPreferencesTableData alloc] init];
    indianapolisColts.teamName = @"Indianapolis Colts";
    indianapolisColts.teamTag = @"colts";
    indianapolisColts.hideSwitch = @(NO);
    indianapolisColts.titleString = indianapolisColts.teamName;
    indianapolisColts.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    return @[dallasCowboys, greenBayPackers, newYorkGiants, pittsburghSteelers, indianapolisColts];
}

- (NSArray *)soccerTagsData {
    PUDPreferencesTableData *arsenalFC = [[PUDPreferencesTableData alloc] init];
    arsenalFC.teamName = @"Arsenal FC";
    arsenalFC.teamTag = @"arsenal";
    arsenalFC.hideSwitch = @(NO);
    arsenalFC.titleString = arsenalFC.teamName;
    arsenalFC.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *chelseaFC = [[PUDPreferencesTableData alloc] init];
    chelseaFC.teamName = @"Chelsea FC";
    chelseaFC.teamTag = @"chelsea";
    chelseaFC.hideSwitch = @(NO);
    chelseaFC.titleString = chelseaFC.teamName;
    chelseaFC.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *manchesterUnitedFC = [[PUDPreferencesTableData alloc] init];
    manchesterUnitedFC.teamName = @"Manchester United FC";
    manchesterUnitedFC.teamTag = @"manu";
    manchesterUnitedFC.hideSwitch = @(NO);
    manchesterUnitedFC.titleString = manchesterUnitedFC.teamName;
    manchesterUnitedFC.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *realMadridFC = [[PUDPreferencesTableData alloc] init];
    realMadridFC.teamName = @"Real Madrid FC";
    realMadridFC.teamTag = @"madrid";
    realMadridFC.hideSwitch = @(NO);
    realMadridFC.titleString = realMadridFC.teamName;
    realMadridFC.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    PUDPreferencesTableData *FCBarecelona = [[PUDPreferencesTableData alloc] init];
    FCBarecelona.teamName = @"FC Barecelona";
    FCBarecelona.teamTag = @"fcbarc";
    FCBarecelona.hideSwitch = @(NO);
    FCBarecelona.titleString = FCBarecelona.teamName;
    FCBarecelona.switchValueChangedBlock = ^(UISwitch *tagSwitch){
        [self valueChangedForTagSwitch:tagSwitch];
    };
    
    return @[arsenalFC, chelseaFC, manchesterUnitedFC, realMadridFC, FCBarecelona];
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
    else if (section == kPUDSettingsFootballSectionIndex) {
        return @"NFL Team Tags";
    }
    else if (section == kPUDSettingsSoccerSectionIndex) {
        return @"FC Team Tags";
    }
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == kPUDSettingsPersonalInformationSectionIndex) {
        return @"Attributes contain specific information about your subscribers such as first and last name, gender, and geographical location.\n\nYou can assign specific information as part of a subscriber attribute to be used as part of sends or subscriber management.\n\nThis app stores first name and last name as attributes.";
    }
    else if (section == kPUDSettingsFootballSectionIndex || section == kPUDSettingsSoccerSectionIndex) {
        return @"Tags are used to specify which messsages a customer wishes to receive. For example, to receive message for a particular NFL or FC team.\n\n";
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
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
