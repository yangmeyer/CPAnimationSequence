
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import "CPAnimationStep.h"

@interface CPAnimationStep()
/** A temporary reverse queue of animation steps, i.e. from last to first.
 It is created when the step is run, and is modified during the animation, 
 and is destroyed when the animation finishes. */
@property (nonatomic, retain) NSMutableArray* consumableSteps;
@end

@implementation CPAnimationStep

@synthesize delay, duration, step, options;
@synthesize consumableSteps;

#pragma mark overrides

- (void) dealloc {
	[consumableSteps release];
	[super dealloc];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@ after:%f for:%f", [self class], self.delay, self.duration];
}

#pragma mark construction

+ (id) for:(NSTimeInterval)duration animate:(AnimationStep)step {
   return [self after:0.0 for:duration options:0 animate:step];
}

+ (id) after:(NSTimeInterval)delay for:(NSTimeInterval)duration animate:(AnimationStep)step {
	return [self after:delay for:duration options:0 animate:step];
}

+ (id) after:(NSTimeInterval)theDelay
		 for:(NSTimeInterval)theDuration
	 options:(UIViewAnimationOptions)theOptions
	 animate:(AnimationStep)theStep {
	
	CPAnimationStep* instance = [[self alloc] init];
	if (instance) {
		instance.delay = theDelay;
		instance.duration = theDuration;
		instance.options = theOptions;
		instance.step = [[theStep copy] autorelease];
	}
	return instance;
}

#pragma mark action

- (NSArray*) animationStepArray {
	// subclasses must override this!
	return [NSArray arrayWithObject:self];
}

- (void) runAnimated:(BOOL)animated {
	if (!self.consumableSteps) {
		self.consumableSteps = [[[NSMutableArray alloc] initWithArray:[self animationStepArray]] autorelease];
	}
	if (![self.consumableSteps count]) { // recursion anchor
		self.consumableSteps = nil;
		return; // we're done
	}
	AnimationStep completionStep = ^{
		[self.consumableSteps removeLastObject];
		[self runAnimated:animated]; // recurse!
	};
	CPAnimationStep* currentStep = [self.consumableSteps lastObject];
	if (animated) {
		[UIView animateWithDuration:currentStep.duration
							  delay:currentStep.delay
							options:currentStep.options
						 animations:currentStep.step
						 completion:^(BOOL finished) {
							 if (finished) {
								 completionStep();
							 }
						 }];
	} else {
		currentStep.step();
		completionStep();
	}
}

- (void) run {
	[self runAnimated:YES];
}

@end
