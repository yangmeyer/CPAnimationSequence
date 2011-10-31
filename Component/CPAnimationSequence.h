
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>
#import "CPAnimationStep.h"

/** 
 A CPAnimationSequence defines a sequence of CPAnimationStep objects. 
 */
@interface CPAnimationSequence : CPAnimationStep

#pragma mark - constructors

+ (id) sequenceWithSteps:(CPAnimationStep*)first, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark - properties (normally already set by the constructor)

/** Animations steps, from first to last. */
@property (nonatomic, retain, readonly) NSArray* steps;

@end
