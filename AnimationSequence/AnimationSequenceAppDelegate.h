//
//  AnimationSequenceAppDelegate.h
//  AnimationSequence
//
//  Created by Yang Meyer on 26.07.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AnimationSequenceViewController;

@interface AnimationSequenceAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet AnimationSequenceViewController *viewController;

@end
