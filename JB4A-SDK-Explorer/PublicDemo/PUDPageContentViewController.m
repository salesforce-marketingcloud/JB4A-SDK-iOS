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
//  PUDPageContentViewController.m
//  PublicDemo
//
//  Created by Matt Lathrop on 6/11/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
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
