CPAnimationSequence
===================

**Describe multi-step animation sequences declaratively.**

Something like this:

	CPAnimationSequence* shakespeare = [CPAnimationSequence sequenceWithSteps:
		[CPAnimationStep           for:0.2 animate:^{ self.romeo.alpha = 1.0;
	                                                       self.julia.alpha = 1.0; }],
		[CPAnimationStep after:1.0 for:0.7 animate:^{
								CGPoint kiss = CGPointMake((self.romeo.center.x + self.julia.center.x)/2,
														   (self.romeo.center.y + self.julia.center.y)/2);
								self.romeo.center = kiss;
								self.julia.center = kiss;
		}],
		[CPAnimationStep after:2.0 for:0.5 animate:[self dramaticDeathAnimationStep]],
		[CPAnimationStep           for:0.0 animate:^{ self.theEnd.hidden = NO; }],
		nil];
	[shakespeare runAnimated:YES];

I described the rationale and possible improvements on the [compeople developer blog on Mobile Apps](http://blog.compeople.eu/apps/?p=43).

### CPAnimationProgram

With the addition of CPAnimationProgram, you can now also **run steps** (and sequences, and programs) **in parallel**, or **overlap** steps (and sequences, and programs).

This is still somewhat experimental, so you might run into problems with particularly complex overlaps. It does seem to work well, though, so give it a try.

### Composite pattern

The component implements the Composite design pattern, which means that you can **nest sequences and programs** as much as device memory and your sanity allow.

Requirements
-------
* CPAnimationSequence uses [ARC](http://developer.apple.com/library/ios/#releasenotes/ObjectiveC/RN-TransitioningToARC/_index.html). If your project doesn’t use ARC, set the `-fobjc-arc` compiler flag on the CPAnimationSequence source files.
* Deployment target iOS 4.3+ (The demo targets iOS 5.0, but is easily adapted for iOS 4.3).

Participate
-------
Feel free to comment, fork, and submit pull requests!

Thanks for the contributions from:

- Karsten Litsche
- Matthew McCroskey
- Stephan Diederich

License
-------
Copyright (c) 2011–2012 compeople AG, 2013 Yang Meyer.

The CPAnimationSequence component is released under the [MIT License](https://github.com/yangmeyer/CPAnimationSequence/blob/master/LICENSE.md).