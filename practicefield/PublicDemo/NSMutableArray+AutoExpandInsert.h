//
//  NSMutableArray+AutoExpandInsert.h
//  PublicDemo
//
//  Created by Matt Lathrop on 5/14/14.
//  Copyright (c) 2014 ExactTarget. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (AutoExpandInsert)

/**
 Adds an object to an NSMutableArray by first expanding the array so that it is large enough to allow the object to be inserted at the specified index. If the array is already large enough for the insert then this acts no differently than if the replaceObjectAtIndex:withObject: method was called.
 
 @param anObject The object with which to insert the object at index index in the array. This value must not be nil.
 @param index The index that the object will be inserted at. The array will automatically be expanded and filled with NSNull objects if this exceeds the current bounds of the array.
 */
- (void)autoExpandInsertObject:(id)anObject atIndex:(NSUInteger)index;

@end
