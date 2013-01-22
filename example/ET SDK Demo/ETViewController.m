//
//  ETViewController.m
//  ET SDK Demo
//
//  Created by Eddie Roger on 9/5/12.
//  Copyright (c) 2012 ExactTarget, Inc. All rights reserved.
//

#import "ETViewController.h"
#import "ETPush.h"

@interface ETViewController ()

-(void)updateLastEventLabelForNotification:(NSNotification *)notif;

@end

@implementation ETViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"FirstName"]) {
        _firstName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"FirstName"];
        [[ETPush pushManager] addAttributeNamed:@"FirstName" value:[[NSUserDefaults standardUserDefaults] valueForKey:@"FirstName"]];
    }

    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"LastName"]) {
        _lastName.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"LastName"];
        [[ETPush pushManager] addAttributeNamed:@"LastName" value:[[NSUserDefaults standardUserDefaults] valueForKey:@"LastName"]];
    }
    
    _lastEvent.text = @"Initialized";
    
    _versionString.text = [NSString stringWithFormat:@"SDK Version %@", ETPushSDKVersionString];
        
    
	// Do any additional setup after loading the view, typically from a nib.
    
    _appHeader.text = NSLocalizedString(@"appHeader", @"Applicaiton header label, stating the name of the app.");
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETRequestStarted
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETRequestNoData
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETRequestFailed
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETRequestComplete
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETRequestFailedOnLoadingResult
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETRequestServiceReturnedError
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETRequestServiceResponseSuccess
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETAuthRequestStarted
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETAuthRequestFailed
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETAuthRequestSuccess
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETAuthRequestFinishedWithFailure
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLastEventLabelForNotification:)
                                                 name:ETRequestFinishedWithFailure
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
    } else {
        return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    }
}

-(IBAction)triggeredETUpdate:(id)sender
{
//    [_sendDataButton setEnabled:NO];
//    [[ETData sharedETData] sendToET];
    [[ETPush pushManager] updateET];
}

-(IBAction)showETData:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ETData"
                                                    message:[[ETData sharedETData] etDataToJson]
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil] ;
    [alert show];
}

-(IBAction)copyETDataToPasteboard:(id)sender
{
    [UIPasteboard generalPasteboard].string = [[ETData sharedETData] etDataToJson]; // well, that was easy.
    [[[UIAlertView alloc] initWithTitle:@"Copied"
                               message:@"Copied ETData to the clipboard. Just thought I'd pop this up to let you know. It was super easy."
                              delegate:nil
                     cancelButtonTitle:@"Thanks"
                      otherButtonTitles:nil, nil] show];
}

-(IBAction)clearAuthCredentials:(id)sender
{
    [[ETPush pushManager] clearSavedAuthToken];
}

-(void)updateLastEventLabelForNotification:(NSNotification *)notif
{
    NSLog(@"Received Notification: %@", notif.name);
    _lastEvent.text = notif.name;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _firstName) {
        [[ETPush pushManager] addAttributeNamed:@"FirstName" value:textField.text];        
        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"FirstName"];
    } else {
        [[ETPush pushManager] addAttributeNamed:@"LastName" value:textField.text];
        [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"LastName"];
    }
}
@end
