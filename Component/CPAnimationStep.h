
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG, 2013 Yang Meyer. All rights reserved.

#import <Foundation/Foundation.h>

/** Generic block type */
typedef void (^CPAnimationStepBlock)(void);

/** Backwards-compatibility */
typedef CPAnimationStepBlock AnimationStep __deprecated;

/** 
 A CPAnimationStep defines a single animation object with a delay, duration, execution block and animation options.
 */
@interface CPAnimationStep : NSObject

#pragma mark - constructors

+ (id) after:(NSTimeInterval)delay
	 animate:(CPAnimationStepBlock)step;

+ (id) for:(NSTimeInterval)duration
   animate:(CPAnimationStepBlock)step;

+ (id) after:(NSTimeInterval)delay
		 for:(NSTimeInterval)duration
	 animate:(CPAnimationStepBlock)step;

+ (id) after:(NSTimeInterval)delay
		 for:(NSTimeInterval)duration
	 options:(UIViewAnimationOptions)theOptions
	 animate:(CPAnimationStepBlock)step;

#pragma mark - properties (normally already set by the constructor)

@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic, copy) CPAnimationStepBlock step;
@property (nonatomic) UIViewAnimationOptions options;

#pragma mark - execution

/** Starts the step execution. */
- (void) runAnimated:(BOOL)animated;
/** Shortcut for [step runAnimated:YES] */
- (void) run;

@end
