CPAnimationSequence
===================

**Declaratively describe animation sequences** that consist
of multiple steps.

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
* Made for projects under [ARC](http://developer.apple.com/library/ios/#releasenotes/ObjectiveC/RN-TransitioningToARC/_index.html); you will therefore need to use SDK 5.0+.
* Deployment target iOS 4.3+ (The demo targets iOS 5.0, but is easily adapted for iOS 4.3).

Participate
-------
Feel free to comment, fork, and submit pull requests!

License
-------
Copyright (c) 2011–2012 compeople AG.

The CPAnimationSequence component is released under the MIT License.

### The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.