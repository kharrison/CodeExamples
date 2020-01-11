//
//  UYLViewController.m
//  SyncMe
//
//  Created by Keith Harrison on 23-Oct-2011 http://useyourloaf.com
//  Copyright (c) 2011 Keith Harrison. All rights reserved.
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

#import "UYLViewController.h"

@implementation UYLViewController

typedef enum { UYLblack, UYLblue, UYLgreen, UYLpurple, UYLred, UYLyellow } UYLcolor;
NSString *kUYLKVStoreBackgroundColorKey = @"backgroundColor";

#pragma mark -
#pragma mark === Set the view background ===
#pragma mark -

- (void)changeBackgroundColor {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UYLcolor color = [defaults integerForKey:kUYLKVStoreBackgroundColorKey];

    switch (color) {
        case UYLblue:
            self.view.backgroundColor = [UIColor blueColor];
            break;
        case UYLgreen:
            self.view.backgroundColor = [UIColor greenColor];
            break;
        case UYLpurple:
            self.view.backgroundColor = [UIColor purpleColor];
            break;
        case UYLred:
            self.view.backgroundColor = [UIColor redColor];
            break;
        case UYLyellow:
            self.view.backgroundColor = [UIColor yellowColor];
            break;
        default:
            self.view.backgroundColor = [UIColor blackColor];
            break;
    }    
}

#pragma mark -
#pragma mark === View Management ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeBackgroundColor];
    
    NSUbiquitousKeyValueStore* store = [NSUbiquitousKeyValueStore defaultStore];
    if (store) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(storeChanged:)
                                                     name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification
                                                   object:store];
        [store synchronize];
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}

#pragma mark -
#pragma mark === Button Action ===
#pragma mark -

- (IBAction)colourChange:(id)sender {
    
    UYLcolor colorTag = [sender tag];
    NSNumber *color = [NSNumber numberWithInteger:colorTag];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:color forKey:kUYLKVStoreBackgroundColorKey];
    
    NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
    if (store) {
        [store setObject:color forKey:kUYLKVStoreBackgroundColorKey];
    }
    [self changeBackgroundColor];
}

#pragma mark -
#pragma mark === iCloud Key-Value Store ===
#pragma mark -

- (void)storeChanged:(NSNotification*)notification {

    NSDictionary *userInfo = [notification userInfo];
    NSNumber *reason = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangeReasonKey];

    if (reason) {

        NSInteger reasonValue = [reason integerValue];
        NSLog(@"storeChanged with reason %d", reasonValue);

        if ((reasonValue == NSUbiquitousKeyValueStoreServerChange) ||
            (reasonValue == NSUbiquitousKeyValueStoreInitialSyncChange)) {

            NSArray *keys = [userInfo objectForKey:NSUbiquitousKeyValueStoreChangedKeysKey];
            NSUbiquitousKeyValueStore *store = [NSUbiquitousKeyValueStore defaultStore];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

            for (NSString *key in keys) {
                id value = [store objectForKey:key];
                [userDefaults setObject:value forKey:key];
                NSLog(@"storeChanged updated value for %@",key);
            }

            [self changeBackgroundColor];
        }
    }    
}

@end
