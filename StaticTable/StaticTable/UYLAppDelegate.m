//
//  UYLAppDelegate.m
//  StaticTable
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2012 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  Neither the name of Keith Harrison nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 


#import "UYLAppDelegate.h"
#import "UYLFirstViewController.h"

@implementation UYLAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

NSString *kUYLSettingsSpeedKey = @"speed";
NSString *kUYLSettingsVolumeKey = @"volume";
NSString *kUYLSettingsWarpDriveKey = @"warp";
NSString *kUYLSettingsShieldsKey = @"shields";
NSString *kUYLSettingsCreditsKey = @"credits";
NSString *kUYLSettingsRetriesKey = @"retries";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:1], kUYLSettingsSpeedKey,
                                 [NSNumber numberWithInteger:1], kUYLSettingsVolumeKey,
                                 [NSNumber numberWithBool:YES], kUYLSettingsWarpDriveKey,
                                 [NSNumber numberWithBool:YES], kUYLSettingsShieldsKey,
                                 [NSNumber numberWithDouble:3.0], kUYLSettingsCreditsKey,
                                 [NSNumber numberWithDouble:1.0], kUYLSettingsRetriesKey,
                                 nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UYLFirstViewController *firstViewController = [[UYLFirstViewController alloc] initWithNibName:@"UYLFirstViewController" bundle:nil];
    
    UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"Settings" bundle:nil];
    UIViewController *settingsViewConroller = [settingsStoryboard instantiateInitialViewController];
    
    settingsViewConroller.title = NSLocalizedString(@"Settings", @"Settings");
    settingsViewConroller.tabBarItem.image = [UIImage imageNamed:@"second"];
        
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:firstViewController, settingsViewConroller, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
