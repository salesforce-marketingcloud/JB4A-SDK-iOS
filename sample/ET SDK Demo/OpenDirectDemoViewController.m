//
//  OpenDirectDemoViewController.m
//  ET SDK Demo
//
//  Created by Eddie Roger on 2/5/13.
//  Copyright (c) 2013 ExactTarget, Inc. All rights reserved.
//

#import "OpenDirectDemoViewController.h"

@interface OpenDirectDemoViewController ()

@end

@implementation OpenDirectDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneButtonPressed:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
