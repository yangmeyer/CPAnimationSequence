
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import "AnimationSequenceViewController.h"
#import "CPAnimationSequence.h"

@implementation AnimationSequenceViewController

@synthesize theBox, startButton, revertButton;

- (void) viewDidUnload {
	[super viewDidUnload];
	self.theBox = nil;
	self.startButton = nil;
	self.revertButton = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (IBAction) startAnimation {
	[[CPAnimationSequence sequenceWithSteps:
	  [CPAnimationStep			 for:0.5 animate:^{ self.startButton.alpha = 0.0; }],
	  [CPAnimationSequence sequenceWithSteps:
	   [CPAnimationStep after:0.5 for:0.3 animate:^{ self.theBox.frame = CGRectMake(150, 150, 100, 100); }],
	   [CPAnimationStep           for:0.3 animate:^{ self.theBox.backgroundColor = [UIColor orangeColor]; }],
	   [CPAnimationStep after:0.5 for:0.5 animate:^{ self.theBox.transform = CGAffineTransformMakeScale(2.0, 2.0); }],
	   nil
	   ],
	  [CPAnimationStep			 for:0.5 animate:^{ self.revertButton.alpha = 1.0; }],
	  nil
	] run];
}

- (IBAction) revertAnimation {
	[[CPAnimationSequence sequenceWithSteps:
	  [CPAnimationStep			 for:0.5 animate:^{ self.revertButton.alpha = 0.0; }],
	  [CPAnimationSequence sequenceWithSteps:
	   [CPAnimationStep after:0.5 for:0.5 animate:^{ self.theBox.transform = CGAffineTransformIdentity; }],
	   [CPAnimationStep           for:0.3 animate:^{ self.theBox.backgroundColor = [UIColor greenColor]; }],
	   [CPAnimationStep after:0.5 for:0.3 animate:^{ self.theBox.frame = CGRectMake(100, 100, 100, 100); }],
	   nil
	   ],
	  [CPAnimationStep			 for:0.5 animate:^{ self.startButton.alpha = 1.0; }],
	  nil
	] run];
}

@end
