//
//  ETTestsHelper.h
//  ET SDK Demo
//
//  Created by Swetha Pendyala (Contractor) on 6/2/14.
//  Copyright (c) 2014 ExactTarget, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ETTestsHelper : NSObject

+ (ETTestsHelper *) testHelp;
- (void) clearDatabaseIfExists;
- (void) enablePoll;
- (void) disablePoll;
- (void) doAdditionalPoll;

@end
