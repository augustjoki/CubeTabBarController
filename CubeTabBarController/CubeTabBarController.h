//
//  CubeTabBarController.h
//  Cube
//
//  Created by August Joki on 7/11/11.
//  Copyright 2011 Concinnous Software. All rights reserved.
//

#import <UIKit/UIKit.h>

// defaults to looking at the cube from the outside
typedef enum {
	CubeTabBarControllerAnimationNone = -1,
	CubeTabBarControllerAnimationOutside = 0,
	CubeTabBarControllerAnimationInside
} CubeTabBarControllerAnimation;

@interface CubeTabBarController : UITabBarController

@property(nonatomic, assign) CubeTabBarControllerAnimation animation;
@property(nonatomic, strong) UIColor *backgroundColor;

@end
