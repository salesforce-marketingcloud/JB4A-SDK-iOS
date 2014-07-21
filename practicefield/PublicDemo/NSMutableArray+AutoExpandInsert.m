//
//  NSMutableArray+AutoExpandInsert.m
//  PublicDemo
//
//  Created by Matt Lathrop on 5/14/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import "NSMutableArray+AutoExpandInsert.h"

@implementation NSMutableArray (AutoExpandInsert)

- (void)autoExpandInsertObject:(id)anObject atIndex:(NSUInteger)index {
    while (self.count <= index) {
        [self addObject:[NSNull null]];
    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

@end
