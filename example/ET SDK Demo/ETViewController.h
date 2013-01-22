//
//  ETViewController.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 9/5/12.
//  Copyright (c) 2012 ExactTarget, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UILabel *_lastEvent;
    IBOutlet UILabel *_appHeader;
    
    IBOutlet UIButton *_sendDataButton;
    
    IBOutlet UILabel *_versionString;
    
    IBOutlet UITextField *_firstName;
    IBOutlet UITextField *_lastName;
    
    IBOutlet UILabel *_appID;
}

-(IBAction)triggeredETUpdate:(id)sender;
-(IBAction)showETData:(id)sender;
-(IBAction)copyETDataToPasteboard:(id)sender;
-(IBAction)clearAuthCredentials:(id)sender;

@end
