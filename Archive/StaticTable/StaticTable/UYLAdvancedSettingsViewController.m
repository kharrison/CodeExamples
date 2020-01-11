//
//  UYLAdvancedSettingsViewController.m
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


#import "UYLAdvancedSettingsViewController.h"
#import "UYLAppDelegate.h"

@interface UYLAdvancedSettingsViewController ()

- (IBAction)switchToggled:(UISwitch *)sender;
- (IBAction)stepperChanged:(UIStepper *)sender;

@property (nonatomic, weak) IBOutlet UISwitch *warpSwitch;
@property (nonatomic, weak) IBOutlet UISwitch *shieldsSwitch;
@property (nonatomic, weak) IBOutlet UILabel *creditsLabel;
@property (nonatomic, weak) IBOutlet UILabel *retriesLabel;
@property (nonatomic, weak) IBOutlet UIStepper *creditsStepper;
@property (nonatomic, weak) IBOutlet UIStepper *retriesStepper;

@end

@implementation UYLAdvancedSettingsViewController

@synthesize warpSwitch=_warpSwitch;
@synthesize shieldsSwitch=_shieldsSwitch;
@synthesize creditsLabel=_creditsLabel;
@synthesize retriesLabel=_retriesLabel;
@synthesize creditsStepper=_creditsStepper;
@synthesize retriesStepper=_retriesStepper;

#define TAG_WARPSWITCH      10
#define TAG_SHIELDSSWITCH   20
#define TAG_CREDITSSTEPPER  30
#define TAG_RETRIESSTEPPER  40

#pragma mark -
#pragma mark === UIViewController ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.warpSwitch.on = [defaults boolForKey:kUYLSettingsWarpDriveKey];
    self.shieldsSwitch.on = [defaults boolForKey:kUYLSettingsShieldsKey];
        
    self.creditsStepper.value = [defaults doubleForKey:kUYLSettingsCreditsKey];
    self.creditsLabel.text = [NSString stringWithFormat:@"%1.0f", self.creditsStepper.value];
    
    self.retriesStepper.value = [defaults doubleForKey:kUYLSettingsRetriesKey];
    self.retriesLabel.text = [NSString stringWithFormat:@"%1.0f", self.retriesStepper.value];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark === Actions ===
#pragma mark -

- (IBAction)switchToggled:(UISwitch *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    switch (sender.tag)
    {
        case TAG_WARPSWITCH:
            [defaults setBool:sender.on forKey:kUYLSettingsWarpDriveKey];
            break;
            
        case TAG_SHIELDSSWITCH:
            [defaults setBool:sender.on forKey:kUYLSettingsShieldsKey];
            break;
    }
}

- (IBAction)stepperChanged:(UIStepper *)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    switch (sender.tag)
    {
        case TAG_CREDITSSTEPPER:
            [defaults setDouble:sender.value forKey:kUYLSettingsCreditsKey];
            self.creditsLabel.text = [NSString stringWithFormat:@"%1.0f", sender.value];
            break;

        case TAG_RETRIESSTEPPER:
            [defaults setDouble:sender.value forKey:kUYLSettingsRetriesKey];
            self.retriesLabel.text = [NSString stringWithFormat:@"%1.0f", sender.value];
            break;
    }
}

@end
