
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011-2012 compeople AG. All rights reserved.

#import "AnimationSequenceViewController.h"
#import "CPAnimationSequence.h"
#import "CPAnimationProgram.h"

@interface AnimationSequenceViewController ()
- (CPAnimationStep*) viewSpecificStartAnimation;
- (CPAnimationStep*) viewSpecificRevertAnimation;
- (void) highlightLabel:(UILabel*)labelToHighlight;
@end

@implementation AnimationSequenceViewController

@synthesize theBox, startButton, revertButton, theIndicator;
@synthesize labelHeader, labelStep1, labelStep2, labelStep3;

#pragma mark - CPAnimationSequence demo

- (IBAction) startAnimation {
	CPAnimationSequence* animationSequence = [CPAnimationSequence sequenceWithSteps:
	  [CPAnimationStep after:0.0 for:0.0 animate:^{ self.labelHeader.text = @"Running:";}],		// zero time start block
	  [CPAnimationStep for:0.5 animate:^{ self.startButton.alpha = 0.0; }],						// first animation
	  [self viewSpecificStartAnimation],														// second animation (composite pattern can be another sequence/program inside)
	  [CPAnimationStep for:0.5 animate:^{ self.revertButton.alpha = 1.0; }],					// third animation
	  [CPAnimationStep after:0.0 for:0.0 animate:^{ self.labelHeader.text = @"Animation:";}],	// zero time completion block
	  nil];
	[animationSequence run];
}

- (IBAction) revertAnimation {
	[[CPAnimationSequence sequenceWithSteps:
	  [CPAnimationStep after:0.0 for:0.0 animate:^{ self.labelHeader.text = @"Running:";}],		// zero time start block
	  [CPAnimationStep for:0.5 animate:^{ self.revertButton.alpha = 0.0; }],					// first animation
	  [self viewSpecificRevertAnimation],														// second animation (composite pattern can be another sequence/program inside)
	  [CPAnimationStep for:0.5 animate:^{ self.startButton.alpha = 1.0; }],						// third animation
	  [CPAnimationStep after:0.0 for:0.0 animate:^{ self.labelHeader.text = @"Animation:";}],	// zero time completion block
	  nil
	] run];
}

#pragma mark - composite pattern ability for CPAnimationSequence

// Note: This part of the animation sequence may be implemented elsewhere.
// Thanks to the composite-pattern implementation, you can define an animation sequence at
// one point and insert it into another sequence/program somewhere else without knowing what happens inside.
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

#pragma mark - composite pattern ability for CPAnimationProgram

// Note: This part of the animation sequence may be implemented elsewhere.
// Thanks to the composite-pattern implementation, you can define an animation program at
// one point and insert it into another sequence/program somewhere else without knowing what happens inside.
- (CPAnimationStep*) viewSpecificRevertAnimation {
	// parallel to the back animation we will animate another sequence here (the arrow)
	return [CPAnimationProgram programWithSteps:
			[CPAnimationSequence sequenceWithSteps:
			  [CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep3];
															self.theBox.transform = CGAffineTransformIdentity; }],
			  [CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep2];
															self.theBox.backgroundColor = [UIColor greenColor]; }],
			  [CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep1];
															self.theBox.frame = CGRectMake(100, 100, 100, 100); }],
			  [CPAnimationStep after:0.0         animate:^{ [self highlightLabel:nil]; }],
			  nil],
			[CPAnimationSequence sequenceWithSteps:
			  [CPAnimationStep after:0.0 for:0.0 animate:^{ self.theIndicator.center=CGPointMake(82,534); }],
	 		  [CPAnimationStep after:0.0 for:0.7 animate:^{ self.theIndicator.alpha=1.0; }],
			  [CPAnimationStep			 for:4.4 animate:^{ self.theIndicator.center=CGPointMake(82,474); }],
			  [CPAnimationStep after:0.0 for:0.7 animate:^{ self.theIndicator.alpha=0.0; }],
			  nil],
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
