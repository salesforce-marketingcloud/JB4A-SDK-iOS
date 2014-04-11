//
//  ETMobilePushDemoViewController.h
//  ContactsDemo
//
//  Created by Eddie Roger on 10/24/13.
//  Copyright (c) 2013 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETMobilePushDemoViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *subscriberKeyField;
@property (weak, nonatomic) IBOutlet UITextField *attributeField;
@property (weak, nonatomic) IBOutlet UISwitch *tagSwitch;

-(IBAction)switchToggled:(id)sender;

@end
