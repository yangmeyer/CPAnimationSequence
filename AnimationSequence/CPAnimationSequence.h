
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>
#import "CPAnimationStep.h"

@interface CPAnimationSequence : NSObject

+ (id) sequenceWithSteps:(CPAnimationStep*)first, ... NS_REQUIRES_NIL_TERMINATION;

/** Animations steps, from first to last. */
@property (nonatomic, retain) NSArray* steps;

- (void) run;
/** Default: animated=YES */
- (void) runAnimated:(BOOL)animated;

@end
