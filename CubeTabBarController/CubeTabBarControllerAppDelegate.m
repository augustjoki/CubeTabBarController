//
//  CubeTabBarControllerAppDelegate.m
//  CubeTabBarController
//
//  Created by August Joki on 7/21/11.
//  Copyright 2011 Concinnous Software. All rights reserved.
//

#import "CubeTabBarControllerAppDelegate.h"

#import "CubeTabBarController.h"

@implementation CubeTabBarControllerAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
	
	
	// creating a set of view controllers with which to test out the animation
	// label is skewed to see the 3d-ness better
	NSMutableArray *array = [[NSMutableArray alloc] init];
	for (int ii = 0; ii < 5; ii++) {
		UIViewController *vc = [[UIViewController alloc] initWithNibName:nil bundle:nil];
		vc.view.backgroundColor = [UIColor colorWithWhite:(ii+1) * 0.2 alpha:1.0];
		UILabel *label = [[UILabel alloc] init];
		label.font = [UIFont systemFontOfSize:36];
		label.text = [NSString stringWithFormat:@"View Controller %d", ii];
		[label sizeToFit];
		vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:[NSString stringWithFormat:@"%d", ii] image:nil tag:0];
		[vc.view addSubview:label];
		label.center = vc.view.center;
		label.transform = CGAffineTransformMakeRotation(M_PI_4);
		[array addObject:vc];
	}
	
	CubeTabBarController *ctbc = [[CubeTabBarController alloc] initWithNibName:nil bundle:nil];
	ctbc.viewControllers = array;
	self.window.rootViewController = ctbc;
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	/*
	 Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	 Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
	 */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	/*
	 Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	 If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	 */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	/*
	 Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
	 */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	/*
	 Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	 */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	/*
	 Called when the application is about to terminate.
	 Save data if appropriate.
	 See also applicationDidEnterBackground:.
	 */
}

@end
