/**
 * Copyright (c) 2014 ExactTarget, Inc.
 * All rights reserved.
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
//  PUDCloudPageInboxDataSource.m
//  PublicDemo
//
//  Created by Matt Lathrop on 7/8/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "PUDCloudPageInboxDataSource.h"

// Libraries
#import "ETMessage.h"

// Views
#import "PUDCloudPageInboxTableViewCell.h"

/**
 *  ET_NOTE: This class inherits from the ExactTargetEnhancedPushDataSource class. You don't have to do this in order to use CloudPages. If you would like to use CloudPages with the default look and datasource handling you can just create an instance of the ExactTargetEnhancedPushDataSource class and set it as your table view's datasource. Also note that you are not required to provide a filter on the messages. Your code will be a lot simpler if you choose not to provide a filter
 */
@interface PUDCloudPageInboxDataSource ()

/**
 *  Predicate that is used when the user wants to view all CloudPages
 */
@property (nonatomic, strong) NSPredicate *allPredicate;

/**
 *  Predicate that is used when the user wants to only view unread CloudPages
 */
@property (nonatomic, strong) NSPredicate *unreadPredicate;

/**
 *  Predicate that is used when the user wants to only view read CloudPages
 */
@property (nonatomic, strong) NSPredicate *readPredicate;

/**
 *  This is used as pointer to the current predicate that should be applied to the ETMessages array
 */
@property (nonatomic, strong) NSPredicate *currentPredicate;

@end

@implementation PUDCloudPageInboxDataSource

- (id)init {
    self = [super init];
    if (self) {
        // set up the predicates
        _allPredicate = [NSPredicate predicateWithFormat:@"1 = 1"];
        _unreadPredicate = [NSPredicate predicateWithFormat:@"isRead = 0"];
        _readPredicate = [NSPredicate predicateWithFormat:@"isRead = 1"];
        _currentPredicate = _allPredicate;
    }
    return self;
}

- (void)setCloudPageInboxFilter:(kCloudPageInboxFilter)filter {
    if (filter == kCloudPageInboxFilterAll) {
        _currentPredicate = _allPredicate;
    }
    else if (filter == kCloudPageInboxFilterUnread) {
        _currentPredicate = _unreadPredicate;
    }
    else if (filter == kCloudPageInboxFilterRead) {
        _currentPredicate = _readPredicate;
    }
}

- (ETMessage *)messageForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     *  ET_NOTE: There is a 'messages' property declared in the ExactTargetEnhancedPushDataSource parent class. It returns an NSArray of all CloudPages the user has been sent (read and unread). Notice on the first line here that it is used in order to retrieve the CloudPage message objects
     */
    NSArray *filteredMessages = [self.messages filteredArrayUsingPredicate:self.currentPredicate];
    ETMessage *message = filteredMessages[indexPath.row];
    return message;
}

#pragma mark - datasource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PUDCloudPageInboxTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPUDReuseIdentifierCloudPageInboxCell forIndexPath:indexPath];
    
    // retrieve the message
    ETMessage *message = [self messageForRowAtIndexPath:indexPath];
    
    // set up the cell
    [cell configureWithMessage:message atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delete the message
        ETMessage *messageToDelete = [self messageForRowAtIndexPath:indexPath];
        [messageToDelete markAsDeleted];
        
        // get mutable copy of messages
        NSMutableArray *tempMessages = [self.messages mutableCopy];
        
        // figure out which message to remove
        NSInteger removeIndex = -1;
        
        for (NSInteger i = 0; i < tempMessages.count; i++) {
            ETMessage *message = tempMessages[i];
            
            if ([message.messageIdentifier isEqualToString:messageToDelete.messageIdentifier]) {
                removeIndex = i;
            }
        }
        
        // remove the message
        [tempMessages removeObjectAtIndex:removeIndex];
        
        /**
         *  ET_NOTE: You do not usually want to set this property yourself (let the SDK handle that), however when deleting you can update this property with the new set that excludes the most recently deleted message
         */
        self.messages = tempMessages;
        
        // delete the row
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    [tableView endUpdates];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /**
     *  ET_NOTE: Here we are filtering the messages provided self.messages using the predicate that mactches the filter currently selected by the user. You only need to do this if you are providing a filter on your table view
     */
    NSArray *filteredMessages = [self.messages filteredArrayUsingPredicate:self.currentPredicate];
    return filteredMessages.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}

@end
