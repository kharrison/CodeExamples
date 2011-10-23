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

#pragma mark -
#pragma mark === Set the view background ===
#pragma mark -

- (void)changeBackgroundColor:(UYLcolor)color {
    
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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UYLcolor color = [defaults integerForKey:@"backgroundColor"];
    [self changeBackgroundColor:color];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark === Button Action ===
#pragma mark -

- (IBAction)colourChange:(id)sender {
    
    UYLcolor color = [sender tag];
    [self changeBackgroundColor:color];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:color forKey:@"backgroundColor"];
    [defaults synchronize];
}

@end
