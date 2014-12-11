
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

@interface AnimationSequenceViewController ()
- (CPAnimationStep*) viewSpecificStartAnimation;
- (void) highlightLabel:(UILabel*)labelToHighlight;
@end

@implementation AnimationSequenceViewController

@synthesize theBox, startButton, revertButton, cancelButton;
@synthesize animationSequence;
@synthesize labelHeader, labelStep1, labelStep2, labelStep3;
@synthesize indicatorShoutout, theIndicator;

#pragma mark - CPAnimationSequence demo

- (IBAction) startAnimation {
	self.animationSequence = [CPAnimationSequence sequenceWithSteps:
	  [CPAnimationStep for:0.0 animate:^{ self.labelHeader.text = @"Running:";}],	// zero time start block
	  [CPAnimationStep for:0.5 animate:^{ self.startButton.alpha = 0.0; }],			// some setup animation
	  [self viewSpecificStartAnimation],											// main animation
	  [CPAnimationStep for:0.5 animate:^{ self.revertButton.alpha = 1.0; }],		// some teardown animation
	  [CPAnimationStep for:0.0 animate:^{ self.labelHeader.text = @"Animation:";
                                          self.cancelButton.enabled = NO; }],	// zero time completion block
	  nil];
	[self.animationSequence run];
    self.cancelButton.enabled = YES;
}

- (IBAction) revertAnimation {
    self.animationSequence = [CPAnimationSequence sequenceWithSteps:
                              [CPAnimationStep for:0.0 animate:^{ self.labelHeader.text = @"Running:";}],	// zero time start block
                              [CPAnimationStep for:0.5 animate:^{ self.revertButton.alpha = 0.0; }],		// some setup animation
                              [self viewSpecificRevertAnimation],											// main animation
                              [CPAnimationStep for:0.5 animate:^{ self.startButton.alpha = 1.0; }],			// some teardown animation
                              [CPAnimationStep for:0.0 animate:^{ self.labelHeader.text = @"Animation:";
                                                                  self.cancelButton.enabled = NO; }],	// zero time completion block
                              nil
                              ];
	[self.animationSequence run];
    self.cancelButton.enabled = YES;
}

- (IBAction) cancelAnimation
{
    [self.animationSequence cancel];
    self.cancelButton.enabled = NO;
    self.startButton.alpha = 1.0;
    self.revertButton.alpha = 0;
}

#pragma mark - composite pattern ability for CPAnimationSequence

// Thanks to the composite-pattern implementation, you can define an animation step, sequence or program at
// one point and insert it into another sequence/program elsewhere.
- (CPAnimationStep*) viewSpecificStartAnimation {
	return [CPAnimationSequence sequenceWithSteps:
			[CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep1];
														  self.theBox.frame = CGRectMake(150, 150, 100, 100); }],
			[CPAnimationStep after:0.7 for:1.0 animate:^{ [self highlightLabel:self.labelStep2];
		self.theBox.backgroundColor = [UIColor orangeColor]; }],
			[CPAnimationStep after:0.7 for:1.0 damping:0.5 velocity:1 options:0 animate:^{
		[self highlightLabel:self.labelStep3];
		self.theBox.transform = CGAffineTransformMakeScale(2.0, 2.0); }],
			[CPAnimationStep after:0.0         animate:^{ [self highlightLabel:nil]; }],
			nil];
}

#pragma mark - composite pattern ability for CPAnimationProgram

- (CPAnimationStep*) viewSpecificRevertAnimation {
	// we run two sequences in parallel: stepping backwards through the steps, and moving an indicator arrow.
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
			[self indicatorMovingInParallelToTheSequence],
			nil];
}

- (CPAnimationSequence*) indicatorMovingInParallelToTheSequence {
	return [CPAnimationSequence sequenceWithSteps:
			 [CPAnimationStep for:0.0 animate:^{ self.theIndicator.center = CGPointMake(82, self.labelStep3.center.y); }],
			 [CPAnimationStep for:0.7 animate:^{ self.theIndicator.alpha = 1.0;
												 self.indicatorShoutout.alpha = 1.0; }],
			 [CPAnimationStep for:4.4 animate:^{ self.theIndicator.center = CGPointMake(82, self.labelStep1.center.y); }],
			[CPAnimationStep for:0.7 animate:^{ self.theIndicator.alpha = 0.0;
												self.indicatorShoutout.alpha = 0.0; }],
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
