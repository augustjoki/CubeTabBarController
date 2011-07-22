//
//  CubeTabBarController.m
//  Cube
//
//  Created by August Joki on 7/11/11.
//  Copyright 2011 Concinnous Software. All rights reserved.
//

#import "CubeTabBarController.h"

#import <QuartzCore/QuartzCore.h>

@implementation CubeTabBarController

- (void)setSelectedViewController:(UIViewController *)next
{
	if (next == self.selectedViewController) {
		return;
	}
	
	self.view.userInteractionEnabled = NO;
	
	NSUInteger nextIndex = [self.viewControllers indexOfObject:next];
	UIViewController *current = self.selectedViewController;
	
	next.view.frame = current.view.frame;
	
	CGFloat halfWidth = current.view.bounds.size.width / 2.0;
	CGFloat duration = 0.7;
	CGFloat perspective = -1.0/1000.0;
	
	UIView *superView = current.view.superview;
	CATransformLayer *transformLayer = [[CATransformLayer alloc] init];
	transformLayer.frame = current.view.layer.bounds;
	
	[current.view removeFromSuperview];
	[transformLayer addSublayer:current.view.layer];
	[transformLayer addSublayer:next.view.layer];
	[superView.layer addSublayer:transformLayer];
	
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	CATransform3D transform = CATransform3DIdentity;
	transform = CATransform3DTranslate(transform, 0, 0, -halfWidth);
	transform = CATransform3DRotate(transform, (nextIndex > self.selectedIndex) ? M_PI_2 : -M_PI_2, 0, 1, 0);
	transform = CATransform3DTranslate(transform, 0, 0, halfWidth);
	next.view.layer.transform = transform;
	[CATransaction commit];
	
	[CATransaction begin];
	[CATransaction setCompletionBlock:^(void) {
		[next.view.layer removeFromSuperlayer];
		[CATransaction begin];
		[CATransaction setDisableActions:YES];
		next.view.layer.transform = CATransform3DIdentity;
		[CATransaction commit];
		[current.view.layer removeFromSuperlayer];
		[superView addSubview:current.view];
		[transformLayer removeFromSuperlayer];
		[super setSelectedViewController:next];
		self.view.userInteractionEnabled = YES;
	}];
	
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	
	transform = CATransform3DIdentity;
	transform.m34 = perspective;
	animation.fromValue = [NSValue valueWithCATransform3D:transform];
	
	transform = CATransform3DIdentity;
	transform.m34 = perspective;
	transform = CATransform3DTranslate(transform, 0, 0, -halfWidth);
	transform = CATransform3DRotate(transform, (nextIndex > self.selectedIndex) ? -M_PI_2 : M_PI_2, 0, 1, 0);
	transform = CATransform3DTranslate(transform, 0, 0, halfWidth);
	animation.toValue = [NSValue valueWithCATransform3D:transform];
	
	animation.duration = duration;
	
	[transformLayer addAnimation:animation forKey:@"rotate"];
	transformLayer.transform = transform;
	
	[CATransaction commit];
}

@end
