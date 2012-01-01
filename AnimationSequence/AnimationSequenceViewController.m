
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011-2012 compeople AG. All rights reserved.

#import "AnimationSequenceViewController.h"
#import "CPAnimationSequence.h"

@interface AnimationSequenceViewController ()
- (CPAnimationStep*) viewSpecificStartAnimation;
@end

@implementation AnimationSequenceViewController

@synthesize theBox, startButton, revertButton;

#pragma mark - CPAnimationSequence demo

- (IBAction) startAnimation {
	CPAnimationSequence* animationSequence = [CPAnimationSequence sequenceWithSteps:
	  [CPAnimationStep for:0.5 animate:^{ self.startButton.alpha = 0.0; }],
	  [self viewSpecificStartAnimation],
	  [CPAnimationStep for:0.5 animate:^{ self.revertButton.alpha = 1.0; }],
	  nil];
	[animationSequence run];
}

- (IBAction) revertAnimation {
	[[CPAnimationSequence sequenceWithSteps:
	  [CPAnimationStep for:0.5 animate:^{ self.revertButton.alpha = 0.0; }],
	  [CPAnimationSequence sequenceWithSteps:
	   [CPAnimationStep after:1.0 for:1.0 animate:^{ self.theBox.transform = CGAffineTransformIdentity; }],
	   [CPAnimationStep           for:1.0 animate:^{ self.theBox.backgroundColor = [UIColor greenColor]; }],
	   [CPAnimationStep after:1.0 for:1.0 animate:^{ self.theBox.frame = CGRectMake(100, 100, 100, 100); }],
	   nil
	   ],
	  [CPAnimationStep for:0.5 animate:^{ self.startButton.alpha = 1.0; }],
	  nil
	] run];
}

// Note: This part of the animation sequence may be implemented elsewhere.
// Thanks to the composite-pattern implementation, you can define an animation sequence at
// one point and insert it into another sequence somewhere else.
- (CPAnimationStep*) viewSpecificStartAnimation {
	return [CPAnimationSequence sequenceWithSteps:
			[CPAnimationStep after:1.0 for:1.0 animate:^{ self.theBox.frame = CGRectMake(150, 150, 100, 100); }],
			[CPAnimationStep           for:1.0 animate:^{ self.theBox.backgroundColor = [UIColor orangeColor]; }],
			[CPAnimationStep after:1.0 for:1.0 animate:^{ self.theBox.transform = CGAffineTransformMakeScale(2.0, 2.0); }],
			nil
			];
}

#pragma mark - UIKit overrides

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
