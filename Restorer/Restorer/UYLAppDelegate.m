//
//  UYLAppDelegate.m
//  Restorer
//
// Created by Keith Harrison http://useyourloaf.com
// Copyright (c) 2013 Keith Harrison. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// Neither the name of Keith Harrison nor the names of its contributors
// may be used to endorse or promote products derived from this software
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


#import "UYLAppDelegate.h"

@implementation UYLAppDelegate

NSString *kUYLSettingsAmazingKey = @"amazing";

#define BUNDLEMINVERSION 3

// Common initilisation code for backward compatibility with iOS 5
- (void)commonFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *appDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                     [NSNumber numberWithBool:YES], kUYLSettingsAmazingKey,
                                     nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
    });
}

// Called before state restoration is performed
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self commonFinishLaunchingWithOptions:launchOptions];
    return YES;
}

// Called after state restortation is performed
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self commonFinishLaunchingWithOptions:launchOptions];
    return YES;
}

// Opt-in to state preservation
- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
{
    return YES;
}

// Opt-in to state restoration
- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
{
    // Retrieve the Bundle Version Key so we can check if the restoration data is from an older
    // version of the App that would not make sense to restore. This might be the case after we
    // have made significant changes to the view hierarchy.
    
    NSString *restorationBundleVersion = [coder decodeObjectForKey:UIApplicationStateRestorationBundleVersionKey];
    if ([restorationBundleVersion integerValue] < BUNDLEMINVERSION)
    {
        NSLog(@"Ignoring restoration data for bundle version: %@",restorationBundleVersion);
        return NO;
    }
    
    // Retrieve the User Interface Idiom (iPhone or iPad) for the device that created the restoration Data.
    // This allows us to ignore the restoration data when the user interface idiom that created the data
    // does not match the current device user interface idiom.
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    UIUserInterfaceIdiom restorationInterfaceIdiom = [[coder decodeObjectForKey:UIApplicationStateRestorationUserInterfaceIdiomKey] integerValue];
    UIUserInterfaceIdiom currentInterfaceIdiom = currentDevice.userInterfaceIdiom;
    if (restorationInterfaceIdiom != currentInterfaceIdiom)
    {
        NSLog(@"Ignoring restoration data for interface idiom: %ld",(long)restorationInterfaceIdiom);
        return NO;
    }
    
    return YES;
}

@end
