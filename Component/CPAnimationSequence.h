
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>
#import "CPAnimationStep.h"

/** 
 A CPAnimationSequence defines a sequence of CPAnimationStep objects. User may run it animated or non animated. 
 */
@interface CPAnimationSequence : NSObject

#pragma mark - constructors

+ (id) sequenceWithSteps:(CPAnimationStep*)first, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark - properties (normally already set by the constructor)

/** Animations steps, from first to last. */
@property (nonatomic, retain) NSArray* steps;

#pragma mark - execution

/** Starts the sequence execution. */
- (void) runAnimated:(BOOL)animated;
/** Shortcut for [seq runAnimated:YES] */
- (void) run;

@end
