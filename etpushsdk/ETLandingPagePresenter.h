//
//  ETLandingPagePresenter.h
//  connections12
//
//  Created by Eddie Roger on 8/17/12.
//
//

#import <UIKit/UIKit.h>

@interface ETLandingPagePresenter : UIViewController<UIWebViewDelegate>
{
    UIWebView *_theWebView;
    UILabel *_pageTitle;
}

@property (nonatomic, copy) NSString *landingPagePath;

-(id)initForLandingPageAt:(NSString *)landingPage;

@end
