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

@synthesize animation;
@synthesize backgroundColor;

- (void)setSelectedViewController:(UIViewController *)next
{
	if (self.animation == CubeTabBarControllerAnimationNone) {
		[super setSelectedViewController:next];
		return;
	}
	
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
	
	// let's be safe about setting stuff on view's we don't control
	UIColor *originalBackgroundColor = superView.backgroundColor;
	superView.backgroundColor = self.backgroundColor;
	
	[CATransaction begin];
	[CATransaction setDisableActions:YES];
	CATransform3D transform = CATransform3DIdentity;
	
	// yes, this switch has a bit of redundant code, but not sure yet if other animations will follow the same pattern
	switch (self.animation) {
		case CubeTabBarControllerAnimationOutside:
			transform = CATransform3DTranslate(transform, 0, 0, -halfWidth);
			transform = CATransform3DRotate(transform, (nextIndex > self.selectedIndex) ? M_PI_2 : -M_PI_2, 0, 1, 0);
			transform = CATransform3DTranslate(transform, 0, 0, halfWidth);
			break;
		case CubeTabBarControllerAnimationInside:
			transform = CATransform3DTranslate(transform, 0, 0, halfWidth);
			transform = CATransform3DRotate(transform, (nextIndex > self.selectedIndex) ? -M_PI_2 : M_PI_2, 0, 1, 0);
			transform = CATransform3DTranslate(transform, 0, 0, -halfWidth);
			break;
		default:
			break;
	}
	
	next.view.layer.transform = transform;
	[CATransaction commit];
	
	[CATransaction begin];
	[CATransaction setCompletionBlock:^(void) {
		[next.view.layer removeFromSuperlayer];
		next.view.layer.transform = CATransform3DIdentity;
		[current.view.layer removeFromSuperlayer];
		superView.backgroundColor = originalBackgroundColor;
		[superView addSubview:current.view];
		[transformLayer removeFromSuperlayer];
		[super setSelectedViewController:next];
		self.view.userInteractionEnabled = YES;
	}];
	
	CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
	
	transform = CATransform3DIdentity;
	transform.m34 = perspective;
	transformAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
	
	transform = CATransform3DIdentity;
	transform.m34 = perspective;
	switch (self.animation) {
		case CubeTabBarControllerAnimationOutside:
			transform = CATransform3DTranslate(transform, 0, 0, -halfWidth);
			transform = CATransform3DRotate(transform, (nextIndex > self.selectedIndex) ? -M_PI_2 : M_PI_2, 0, 1, 0);
			transform = CATransform3DTranslate(transform, 0, 0, halfWidth);
			break;
		case CubeTabBarControllerAnimationInside:
			transform = CATransform3DTranslate(transform, 0, 0, halfWidth);
			transform = CATransform3DRotate(transform, (nextIndex > self.selectedIndex) ? M_PI_2 : -M_PI_2, 0, 1, 0);
			transform = CATransform3DTranslate(transform, 0, 0, -halfWidth);
			break;
		default:
			break;
	}
	
	transformAnimation.toValue = [NSValue valueWithCATransform3D:transform];
	
	transformAnimation.duration = duration;
	
	[transformLayer addAnimation:transformAnimation forKey:@"rotate"];
	transformLayer.transform = transform;
	
	[CATransaction commit];
}

@end
