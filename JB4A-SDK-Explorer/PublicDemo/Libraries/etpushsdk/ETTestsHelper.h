//
//  ETTestsHelper.h
//  ET SDK Demo
//
//  Created by Swetha Pendyala (Contractor) on 6/2/14.
//  Copyright © 2015 Salesforce Marketing Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ETTestsHelper : NSObject

+ (ETTestsHelper *) testHelp;
- (void) clearDatabaseIfExists;
- (void) enablePoll;
- (void) disablePoll;
- (void) doAdditionalPoll;

@end
