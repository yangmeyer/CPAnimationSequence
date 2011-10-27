
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import "CPAnimationSequence.h"

@interface CPAnimationSequence ()
/** A temporary reverse queue of animation steps, i.e. from last to first.
	It is created when the sequence is run, and is modified during the animation 
	sequence, and is destroyed when the animation sequence finishes. */
@property (nonatomic, retain) NSMutableArray* consumableSteps;
@end

#pragma mark -
@implementation CPAnimationSequence

@synthesize steps;
@synthesize consumableSteps;

#pragma mark - Object lifecycle

+ (id) sequenceWithSteps:(CPAnimationStep*)first, ... {
	CPAnimationSequence* instance = [[self alloc] init];
	if (instance) {
		NSMutableArray* tempSteps = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
		va_list args;
		va_start(args, first);
		[tempSteps insertObject:first atIndex:0];
		CPAnimationStep* aStep;
		while ((aStep = va_arg(args, CPAnimationStep*))) {
			[tempSteps insertObject:aStep atIndex:0];
		}
		instance.steps = [NSArray arrayWithArray:tempSteps];
		va_end(args);
	}
	return instance;
}

- (void) dealloc {
	[steps release], steps = nil;
	[consumableSteps release], consumableSteps = nil;
	[super dealloc];
}

#pragma mark - Run the sequence

- (void) run {
	[self runAnimated:YES];
}

- (void) runAnimated:(BOOL)animated {
	if (!self.consumableSteps) {
		self.consumableSteps = [[[NSMutableArray alloc] initWithArray:self.steps] autorelease];
	}
	if ([self.consumableSteps count] == 0) { // recursion anchor
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

@end
