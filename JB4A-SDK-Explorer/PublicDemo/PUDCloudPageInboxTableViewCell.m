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
//  PUDCloudPagesInboxTableViewCell.m
//  PublicDemo
//
//  Created by Matt Lathrop on 7/8/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
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
