
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^AnimationStep)(void);

@interface CPAnimationStep : NSObject

+ (id) for:(NSTimeInterval)duration
   animate:(AnimationStep)step;

+ (id) after:(NSTimeInterval)delay
		 for:(NSTimeInterval)duration
	 animate:(AnimationStep)step;

/** Defaults: delay=0.0, options=0. */
+ (id) after:(NSTimeInterval)delay
		 for:(NSTimeInterval)duration
	 options:(UIViewAnimationOptions)theOptions
	 animate:(AnimationStep)step;

@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic, retain) AnimationStep step; // copy/autorelease before giving it to the setter
@property (nonatomic) UIViewAnimationOptions options;

@end
