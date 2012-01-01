
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011-2012 compeople AG. All rights reserved.

#import "AnimationSequenceViewController.h"
#import "CPAnimationSequence.h"

@interface AnimationSequenceViewController ()
- (CPAnimationStep*) viewSpecificStartAnimation;
- (void) highlightLabel:(UILabel*)labelToHighlight;
@end

@implementation AnimationSequenceViewController

@synthesize theBox, startButton, revertButton;
@synthesize labelStep1, labelStep2, labelStep3;

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
	   [CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep3];
													 self.theBox.transform = CGAffineTransformIdentity; }],
	   [CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep2];
													 self.theBox.backgroundColor = [UIColor greenColor]; }],
	   [CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep1];
													 self.theBox.frame = CGRectMake(100, 100, 100, 100); }],
	   [CPAnimationStep after:0.0         animate:^{ [self highlightLabel:nil]; }],
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
			[CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep1];
														  self.theBox.frame = CGRectMake(150, 150, 100, 100); }],
			[CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep2];
														  self.theBox.backgroundColor = [UIColor orangeColor]; }],
			[CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep3];
														  self.theBox.transform = CGAffineTransformMakeScale(2.0, 2.0); }],
			[CPAnimationStep after:0.0         animate:^{ [self highlightLabel:nil]; }],
			nil];
}

#pragma mark - Helper

- (void) highlightLabel:(UILabel*)labelToHighlight {
	for (UILabel* aStepLabel in [NSArray arrayWithObjects:self.labelStep1, self.labelStep2, self.labelStep3, nil]) {
		aStepLabel.backgroundColor = (aStepLabel == labelToHighlight
									  ? [UIColor colorWithWhite:0.9 alpha:1.0]
									  : [UIColor clearColor]);
	}
}

#pragma mark - UIKit overrides

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
