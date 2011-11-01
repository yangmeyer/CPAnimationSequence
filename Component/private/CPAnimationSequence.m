
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import "CPAnimationSequence.h"

@interface CPAnimationStep(hidden)
- (NSArray*) animationStepArray;
@end

@interface CPAnimationSequence()
@property (nonatomic, retain) NSArray* steps;
@end

#pragma mark -
@implementation CPAnimationSequence

@synthesize steps;

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
	[steps release];
	[super dealloc];
}

#pragma mark - property override

- (void)setDelay:(NSTimeInterval)delay {
	// TODO: clarify how to handle this
    NSAssert(NO, @"Delay for a sequence is not allowed!!");
}

- (void)setDuration:(NSTimeInterval)duration {
	// TODO: clarify what does it mean for the steps? Is the duration of the sequence 
	// more important than the durations of it's steps?
    NSAssert(NO, @"Duration for a sequence is not allowed!!");
}

- (void)setOptions:(UIViewAnimationOptions)options {
	// TODO clarify what does it mean for the steps? Is that some kind of global option for all steps?
    NSAssert(NO, @"Options for a sequence are not allowed!!");
}

#pragma mark - build the sequence

- (NSArray*) animationStepArray {
	NSMutableArray* array = [NSMutableArray arrayWithCapacity:[self.steps count]];
	for (CPAnimationStep* current in self.steps) {
		[array addObjectsFromArray:[current animationStepArray]];
	}
	return array;
}

@end
