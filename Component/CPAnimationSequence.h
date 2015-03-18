
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011-2012 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>
#import "CPAnimationStep.h"

/** 
 A CPAnimationSequence defines a sequence of CPAnimationStep objects, which can
 be `-run` animatedly or non-animatedly.
 
 CPAnimationSequence implements the Composite design pattern, with CPAnimationStep
 as the base class.
 
 The delay property will be interpreted from end point of the previous step.
 */
@interface CPAnimationSequence : CPAnimationStep

#pragma mark - constructors

+ (id) sequenceWithSteps:(CPAnimationStep*)first, ... NS_REQUIRES_NIL_TERMINATION;
+ (id) sequenceWithStepsByArray:(NSArray *)steps;
+ (id) sequenceWithStepsByArray:(NSArray *)steps factor:(CGFloat)factor;

#pragma mark - properties

/** Animations steps, from first to last. */
@property (nonatomic, strong, readonly) NSArray* steps;
@property (nonatomic, assign) CGFloat factor;

@end
