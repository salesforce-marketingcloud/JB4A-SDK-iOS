//
//  ETURLConnection.h
//  ET SDK Demo
//
//  Created by Eddie Roger on 9/24/12.
//  Copyright (c) 2012 ExactTarget, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GenericUpdate.h"

@interface ETURLConnection : NSURLConnection

@property (nonatomic) int tag;
@property (nonatomic, strong) GenericUpdate *sendingObject;
//@property (nonatomic, strong) NSHTTPURLResponse *responseCode;
//@property (nonatomic, strong) NSMutableData *responseData;

@end
