
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 compeople AG. All rights reserved.

#import <UIKit/UIKit.h>

@class CPAnimationSequence;

@interface AnimationSequenceViewController : UIViewController

@property (nonatomic, assign) IBOutlet UIView* theBox;
@property (nonatomic, assign) IBOutlet UIButton* startButton;
@property (nonatomic, assign) IBOutlet UIButton* revertButton;

- (IBAction) startAnimation;
- (IBAction) revertAnimation;

@end
