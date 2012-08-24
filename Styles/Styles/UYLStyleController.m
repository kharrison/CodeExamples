//
//  UYLStyleController.m
//  Styles
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


#import "UYLStyleController.h"
#import "UYLRotatingViewController.h"
#import "UYLResetButton.h"
#import "UYLOkButton.h"
#import "UYLZeroButton.h"

@implementation UYLStyleController

+ (void)applyStyle
{
    // UINavigationBar
    UIImage *navBarImage = [UIImage imageNamed:@"navbar"];
    navBarImage = [navBarImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    
    UIImage *navBarLandscapeImage = [UIImage imageNamed:@"navbar-landscape"];
    navBarLandscapeImage = [navBarLandscapeImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    [navigationBarAppearance setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setBackgroundImage:navBarLandscapeImage forBarMetrics:UIBarMetricsLandscapePhone];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], UITextAttributeTextColor, nil];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
    
    UIImage *backButtonImage = [UIImage imageNamed:@"back-button"];
    backButtonImage = [backButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25.0, 0, 6.0)];
    
    UIImage *backButtonLandscapeImage = [UIImage imageNamed:@"back-button-landscape"];
    backButtonLandscapeImage = [backButtonLandscapeImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25.0, 0, 6.0)];
    
    UIBarButtonItem *barButtonItemAppearance = [UIBarButtonItem appearance];
    [barButtonItemAppearance setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [barButtonItemAppearance setBackButtonBackgroundImage:backButtonLandscapeImage forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];

    
    // UIButton
    UIImage *defaultButtonImage = [UIImage imageNamed:@"steel-button"];
    defaultButtonImage = [defaultButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    [[UIButton appearanceWhenContainedIn:[UYLRotatingViewController class], nil] setBackgroundImage:defaultButtonImage forState:UIControlStateNormal];
    
    UIImage *okButtonImage = [UIImage imageNamed:@"green-button"];
    okButtonImage = [okButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    [[UYLOkButton appearanceWhenContainedIn:[UYLRotatingViewController class], nil] setBackgroundImage:okButtonImage forState:UIControlStateNormal];

    UIImage *zeroButtonImage = [UIImage imageNamed:@"orange-button"];
    zeroButtonImage = [zeroButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    [[UYLZeroButton appearanceWhenContainedIn:[UYLRotatingViewController class], nil] setBackgroundImage:zeroButtonImage forState:UIControlStateNormal];

    UIImage *resetButtonImage = [UIImage imageNamed:@"red-button"];
    resetButtonImage = [resetButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    [[UYLResetButton appearanceWhenContainedIn:[UYLRotatingViewController class], nil] setBackgroundImage:resetButtonImage forState:UIControlStateNormal];
    [[UYLResetButton appearanceWhenContainedIn:[UYLRotatingViewController class], nil] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    // Set some colors
    UIColor *mainColor = [UIColor darkGrayColor];
    UIColor *altColor = [UIColor lightGrayColor];


    // UILabel
    UILabel *labelAppearance = [UILabel appearanceWhenContainedIn:[UYLRotatingViewController class], nil];
    [labelAppearance setTextColor:mainColor];
    
    
    // UIActivityIndicator
    [[UIActivityIndicatorView appearance] setColor:[UIColor redColor]];

    
    // UIProgressView
    [[UIProgressView appearance] setProgressTintColor:mainColor];
    [[UIProgressView appearance] setTrackTintColor:altColor];

    
    // UISwitch
    [[UISwitch appearance] setOnTintColor:altColor];

    
    // UISlider
    [[UISlider appearance] setMinimumTrackTintColor:mainColor];
    [[UISlider appearance] setMaximumTrackTintColor:altColor];
    [[UISlider appearance] setThumbTintColor:[UIColor redColor]];
    
    
    // UISegmentedControl
    [[UISegmentedControl appearance] setBackgroundImage:defaultButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:zeroButtonImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

    UIImage *dividerImage = [UIImage imageNamed:@"divider"];
    [[UISegmentedControl appearance] setDividerImage:dividerImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

@end
