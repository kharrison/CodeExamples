//
//  UYLAppDelegate.m
//  restore
//
//  Created by Keith Harrison on 17/03/2013.
//  Copyright (c) 2013 Keith Harrison. All rights reserved.
//

#import "UYLAppDelegate.h"

@implementation UYLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}
							
- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    return YES;
}

@end
