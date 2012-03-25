
//  Created by Karsten Litsche on 25.03.12.
//  Copyright (c) 2012 compeople AG. All rights reserved.

#import "CPAnimationProgram.h"

@interface CPAnimationStep(hidden)
- (NSArray*) animationStepArray;
@end

@interface CPAnimationProgram()
@property (nonatomic, strong, readwrite) NSArray* steps;
@end

#pragma mark -
@implementation CPAnimationProgram

@synthesize steps;

#pragma mark - Object lifecycle

+ (id) programWithSteps:(CPAnimationStep*)first, ... {
	CPAnimationProgram* instance = [[self alloc] init];
	if (instance) {
		NSMutableArray* tempSteps = [[NSMutableArray alloc] initWithCapacity:10];
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


#pragma mark - property override

- (void) setDelay:(NSTimeInterval)delay {
    NSAssert(NO, @"Setting a delay on a program is undefined and therefore disallowed!");
}

- (void) setDuration:(NSTimeInterval)duration {
    NSAssert(NO, @"Setting a duration on a program is undefined and therefore disallowed!");
}

- (void) setOptions:(UIViewAnimationOptions)options {
    NSAssert(NO, @"Setting options on a program is undefined and therefore disallowed!");
}

#pragma mark - build the program

- (NSArray*) animationStepArray {
	NSMutableArray* array = [NSMutableArray arrayWithCapacity:[self.steps count]];
	for (CPAnimationStep* current in self.steps) {
		[array addObjectsFromArray:[current animationStepArray]];
	}
	return array;
}

#pragma mark - pretty-print

- (NSString*) description {
	NSMutableString* programBody = [[NSMutableString alloc] initWithCapacity:100*[self.steps count]];
	for (CPAnimationStep* step in self.steps) {
		[programBody appendString:[step description]];
	}
	// indent
	[programBody replaceOccurrencesOfString:@"\n"
								 withString:@"\n  "
									options:NSCaseInsensitiveSearch
									  range:NSMakeRange(0, [programBody length])];
	return [NSString stringWithFormat:@"\n(program:%@\n)", programBody];
}

@end
