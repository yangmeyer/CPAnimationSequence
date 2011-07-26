
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import <Foundation/Foundation.h>

typedef void (^AnimationStep)(void);

@interface CPAnimationStep : NSObject

+ (id) after:(NSTimeInterval)delay
		 for:(NSTimeInterval)duration
	 options:(UIViewAnimationOptions)theDuration
	 animate:(AnimationStep)step;

@property (nonatomic) NSTimeInterval delay;
@property (nonatomic) NSTimeInterval duration;
@property (nonatomic, retain) AnimationStep step; // copy/autorelease before giving it to the setter
@property (nonatomic) UIViewAnimationOptions options;

@end
