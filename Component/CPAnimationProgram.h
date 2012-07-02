
//  Created by Karsten Litsche on 25.03.12.
//  Copyright (c) 2012 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>
#import "CPAnimationStep.h"

/** 
 A CPAnimationProgram defines a program of CPAnimationStep objects, which can
 be `-run` animatedly or non-animatedly.
 
 The delay property will be interpreted from start point of the program.
 
 CPAnimationProgram implements the Composite design pattern, with CPAnimationStep
 as the base class.
 */
@interface CPAnimationProgram : CPAnimationStep

#pragma mark - constructors

+ (id) programWithSteps:(CPAnimationStep*)first, ... NS_REQUIRES_NIL_TERMINATION;

#pragma mark - properties

/** Animations steps */
@property (nonatomic, strong, readonly) NSArray* steps;

@end
