CPAnimationSequence
===================

With this component you can _declaratively describe animation sequences_ that consist
of multiple steps. (Oh, and then you can _run_ them, if you like.)

Something like this:

	CPAnimationSequence* shakespeare = [CPAnimationSequence sequenceWithSteps:
		[CPAnimationStep           for:0.2 animate:^{ self.romeo.alpha = 1.0; }],
		[CPAnimationStep           for:0.2 animate:^{ self.julia.alpha = 1.0;  }],
		[CPAnimationStep after:1.0 for:0.7 animate:^{
								CGPoint love = CGPointMake((self.romeo.center.x + self.julia.center.x)/2,
														   (self.romeo.center.y + self.julia.center.y)/2);
								self.romeo.center = love;
								self.julia.center = love;
		}],
		[CPAnimationStep after:2.0 for:0.5 animate:^{ self.romeo.alpha = 0.0;
													  self.julia.alpha = 0.0; }]
		nil];
	[shakespeare run];

I described the rationale and possible improvements on the [compeople developer blog on Mobile Apps](http://blog.compeople.eu/apps/?p=43).

Feel free to comment, fork, and submit pull requests!

Requirements
------------
* Made for projects under [ARC](http://developer.apple.com/library/ios/#releasenotes/ObjectiveC/RN-TransitioningToARC/_index.html); you will therefore need to use SDK 5.0+.
* Deployment target iOS 4.3+ (The demo targets iOS 5.0, but is easily adapted for iOS 4.3).

License
-------
The CPAnimationSequence component is released under the MIT License.

The MIT License (MIT)
Copyright (c) 2011–2012 compeople AG

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.