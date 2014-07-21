//
//  PUDCloudPagesInboxTableViewCell.m
//  PublicDemo
//
//  Created by Matt Lathrop on 7/8/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDCloudPageInboxTableViewCell.h"

// Libraries
#import "ETMessage.h"
#import <QuartzCore/QuartzCore.h>

@interface PUDCloudPageInboxTableViewCell ()

@property (nonatomic, strong) UIView *unreadView;

@end

@implementation PUDCloudPageInboxTableViewCell

- (void)configureWithMessage:(ETMessage *)message atIndexPath:(NSIndexPath *)indexPath {
    // create the date formatter
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceTokenOne;
    dispatch_once(&onceTokenOne, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    });
    
    // create the time formatter
    static NSDateFormatter *timeFormatter = nil;
    static dispatch_once_t onceTokenTwo;
    dispatch_once(&onceTokenTwo, ^{
        timeFormatter = [[NSDateFormatter alloc] init];
        timeFormatter.timeStyle = NSDateFormatterShortStyle;
    });
    
    // setup views
    self.messageTitleLabel.text = message.subject;
    self.messageStartDateLabel.text = [NSString stringWithFormat:@"%@ at %@",  [dateFormatter stringFromDate:message.startDate], [timeFormatter stringFromDate:message.startDate]].uppercaseString;
    
    // handle read status
    if (!message.read) {
        [self showUnreadView];
    }
    else {
        [self hideUnreadView];
    }
}

- (void)showUnreadView {
    if (!self.unreadView) {
        CGFloat diameter = 12.0;
        self.unreadView = [[UIView alloc] initWithFrame:CGRectMake(8, 16, diameter, diameter)];
        self.unreadView.backgroundColor = [[UIColor etPrimaryBlue] colorWithAlphaComponent:0.9];
        self.unreadView.layer.cornerRadius = diameter / 2.0;
        [self.contentView addSubview:self.unreadView];
    }
    
    self.unreadView.hidden = NO;
}

- (void)hideUnreadView {
    if (self.unreadView) {
        self.unreadView.hidden = YES;
    }
}

@end
