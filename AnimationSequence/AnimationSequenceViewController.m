
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import "AnimationSequenceViewController.h"
#import "CPAnimationSequence.h"

@implementation AnimationSequenceViewController

@synthesize theBox;
@synthesize sequence;

- (void) dealloc {
	[theBox release];
	[sequence release];
	[super dealloc];
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
	[super viewDidLoad];
	self.sequence = [CPAnimationSequence sequenceWithSteps:
		[CPAnimationStep after:0.5 for:0.3 options:0 animate:^{
			self.theBox.frame = CGRectMake(150, 150, 100, 100);
		}],
		[CPAnimationStep after:0.5 for:0.3 options:0 animate:^{
			self.theBox.backgroundColor = [UIColor orangeColor];
		}],
		[CPAnimationStep after:0.5 for:0.5 options:0 animate:^{
			self.theBox.transform = CGAffineTransformMakeScale(2.0, 2.0);
		}],
		nil];
}

- (void) viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.sequence run];
}

- (void) viewDidUnload {
	self.theBox = nil;
	self.sequence = nil;
	[super viewDidUnload];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
