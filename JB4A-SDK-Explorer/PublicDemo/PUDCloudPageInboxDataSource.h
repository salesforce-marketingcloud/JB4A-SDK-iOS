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
//  PUDCloudPageInboxDataSource.h
//  PublicDemo
//
//  Created by Matt Lathrop on 7/8/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <UIKit/UIKit.h>

// Libraries
#import "ExactTargetEnhancedPushDataSource.h"

@class ETMessage;

/**
 *  ET_NOTE: This class inherits from the ExactTargetEnhancedPushDataSource class. You don't have to do this in order to use CloudPages. If you would like to use CloudPages with the default look and datasource handling you can just create an instance of the ExactTargetEnhancedPushDataSource class and set it as your table view's datasource
 */
@interface PUDCloudPageInboxDataSource : ExactTargetEnhancedPushDataSource

/**
 *  This enum is used in order to control filtering of messages
 */
typedef enum {
    kCloudPageInboxFilterAll,
    kCloudPageInboxFilterUnread,
    kCloudPageInboxFilterRead
} kCloudPageInboxFilter;

/**
 *  This is used to control cloudpage message filtering inside the UI
 *
 *  @param filter The enum corresponding to the filter that is currently selected
 */
- (void)setCloudPageInboxFilter:(kCloudPageInboxFilter)filter;

/**
 *  Helper method providing a quick way to retrieve the ETMessage that is at the current indexPath. This class provides this method due to the way the filtering is handled
 *
 *  @param indexPath The indexPath of the message to retrieve
 *
 *  @return The ETMessage object containing the CloudPage message along with other good stuff
 */
- (ETMessage *)messageForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
