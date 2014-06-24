//
//  PUDPageContentViewController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 6/11/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDPageContentViewController.h"

// Controllers
#import "PBWebViewController.h"
#import "PUDNavigationController.h"

@interface PUDPageContentViewController ()

@end

@implementation PUDPageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // this is needed due to supporting both iOS 6 and 7
    if (!IOS_PRE_7_0) {
        self.webView.scrollView.contentInset = self.webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    }
    
    // set up the web view
    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView loadData:[self.html dataUsingEncoding:NSUTF8StringEncoding] MIMEType:nil textEncodingName:nil baseURL:nil];
}

#pragma mark - webview delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (navigationType == UIWebViewNavigationTypeOther) {
        return YES;
    }
    
    PBWebViewController *webViewController = [[PBWebViewController alloc] init];
    webViewController.URL = request.URL;
    webViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close\t" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonTapped:)];
    
    PUDNavigationController *navController = [[PUDNavigationController alloc] initWithRootViewController:webViewController];
    navController.navigationItem.title = @"Push Received";
    
    UIViewController *presentingController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    [presentingController presentViewController:navController
                                       animated:YES
                                     completion:nil];
    
    return NO;
}

- (void)doneButtonTapped:(id)sender {
    UIViewController *presentingController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [presentingController dismissViewControllerAnimated:YES completion:nil];
}

@end
