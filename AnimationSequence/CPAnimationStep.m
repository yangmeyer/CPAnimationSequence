
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import "CPAnimationStep.h"

@implementation CPAnimationStep

@synthesize delay;
@synthesize duration;
@synthesize step;
@synthesize options;

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

@end
