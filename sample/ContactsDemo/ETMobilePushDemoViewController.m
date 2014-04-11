//
//  ETMobilePushDemoViewController.m
//  ContactsDemo
//
//  Created by Eddie Roger on 10/24/13.
//  Copyright (c) 2013 ExactTarget. All rights reserved.
//
//
//  This is a sample implementation of using MobilePush in a real application. Your individual use cases may vary.

#import "ETMobilePushDemoViewController.h"

#import "ETPush.h"

@interface ETMobilePushDemoViewController ()

-(void)setupValuesFromPlaces;
-(NSString *)textFieldToString:(UITextField *)field;

@end

@implementation ETMobilePushDemoViewController

static NSString * const ETDemoFirstNameField        = @"FistNameField";
static NSString * const ETDemoLastNameField         = @"LastNameField";
static NSString * const ETDemoSubscriberKeyField    = @"SubKeyField";
static NSString * const ETDemoAttributeField        = @"AttrField";
static NSString * const ETDemoTagSwitchField        = @"TagField";
static NSString * const ETDemoTagValue              = @"ColtsFan";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     This will set up the UI from cached values. It could be done in viewDidLoad, but is moved for simplicity sake
     */
    [self setupValuesFromPlaces];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];

}

/**
 The ET SDK will persist some data, but not all. Specifically, the SDK will persist attributes and tags for you, but not all of your app's data. 
 
 This method will query the SDK for it's tags and attributes and set the various UI elements correctly. It is an implementation, but not necessarily the right one for every application.
 */
-(void)setupValuesFromPlaces
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:ETDemoFirstNameField]) {
        self.firstNameField.text = [defaults objectForKey:ETDemoFirstNameField];
        [[ETPush pushManager] addAttributeNamed:@"FirstName" value:[defaults objectForKey:ETDemoFirstNameField]];
    }
    
    if ([defaults objectForKey:ETDemoLastNameField]) {
        self.lastNameField.text = [defaults objectForKey:ETDemoLastNameField];
        [[ETPush pushManager] addAttributeNamed:@"LastName" value:[defaults objectForKey:ETDemoLastNameField]];
    }
    
    if ([defaults objectForKey:ETDemoSubscriberKeyField]) {
        self.subscriberKeyField.text = [defaults objectForKey:ETDemoSubscriberKeyField];
        [[ETPush pushManager] setSubscriberKey:[defaults objectForKey:ETDemoSubscriberKeyField]];
    }
    
    if ([defaults objectForKey:ETDemoAttributeField]) {
        self.attributeField.text = [defaults objectForKey:ETDemoAttributeField];
    }
    
    if ([defaults objectForKey:ETDemoTagSwitchField]) {
        self.tagSwitch.on = [[defaults objectForKey:ETDemoTagSwitchField] boolValue];
        [[ETPush pushManager] addTag:ETDemoTagValue];
    } else {
        self.tagSwitch.on = NO;
    }
}

// They should really let us set description on a field. Like, really.
-(NSString *)textFieldToString:(UITextField *)field
{
    if (field == self.firstNameField) {
        return @"First Name";
    } else if (field == self.lastNameField) {
        return @"Last Name";
    } else if (field == self.subscriberKeyField) {
        return @"Subscriber Key";
    } else if (field == self.attributeField) {
        return @"Attribute";
    } else {
        return @"Unknown";
    }
    
}

- (IBAction)switchToggled:(UISwitch *)sender
{
    NSLog(@"Tag switch state is %@", sender.on ? @"on" : @"off");
    [[NSUserDefaults standardUserDefaults] setBool:sender.on forKey:ETDemoTagSwitchField];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (sender.on) {
        [[ETPush pushManager] addTag:ETDemoTagValue];
    } else {
        [[ETPush pushManager] removeTag:ETDemoTagValue];
    }
}

#pragma mark - UITextFieldDelegate Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.firstNameField) {
        [self.lastNameField becomeFirstResponder];
    } else if (textField == self.lastNameField) {
        [self.subscriberKeyField becomeFirstResponder];
    } else if (textField == self.subscriberKeyField) {
        [self.attributeField becomeFirstResponder];
    } else if (textField == self.attributeField) {
        [textField resignFirstResponder];
    } else {
        [textField resignFirstResponder];
    }

    return NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"Field %@ will have value %@", [self textFieldToString:textField], textField.text);
    if (textField == self.firstNameField) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:ETDemoFirstNameField];
    } else if (textField == self.lastNameField) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:ETDemoLastNameField];
    } else if (textField == self.subscriberKeyField) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:ETDemoSubscriberKeyField];
    } else if (textField == self.attributeField) {
        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:ETDemoAttributeField];
    } else {
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self setupValuesFromPlaces]; // This makes sure that the SDK is updated, since the methods to populate it's data are up there.
}

@end
