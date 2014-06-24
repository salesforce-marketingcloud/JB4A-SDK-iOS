//
//  PUDPageContentViewController.h
//  PublicDemo
//
//  Created by Matt Lathrop on 6/11/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PUDPageContentViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property NSUInteger pageIndex;

@property (nonatomic, strong) NSString *html;

@end
