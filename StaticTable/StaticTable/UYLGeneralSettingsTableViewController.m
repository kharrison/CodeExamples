//
//  UYLGeneralSettingsTableViewController.m
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


#import "UYLGeneralSettingsTableViewController.h"
#import "UYLAppDelegate.h"

@interface UYLGeneralSettingsTableViewController ()

@property (nonatomic) NSUInteger speed;
@property (nonatomic) NSUInteger volume;

@end

@implementation UYLGeneralSettingsTableViewController

@synthesize speed=_speed;
@synthesize volume=_volume;

#define SECTION_SPEED   0
#define SECTION_VOLUME  1

#pragma mark -
#pragma mark === UIViewController ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.speed = [defaults integerForKey:kUYLSettingsSpeedKey];
    self.volume = [defaults integerForKey:kUYLSettingsVolumeKey];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark === UITableViewDataSource ===
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    switch (section)
    {
        case SECTION_SPEED:
            if (row == self.speed)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;

        case SECTION_VOLUME:
            if (row == self.volume)
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;
    }
    return cell;
}

#pragma mark -
#pragma mark === UITableViewDelegate ===
#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    switch (section)
    {
        case SECTION_SPEED:
            self.speed = row;
            [defaults setInteger:row forKey:kUYLSettingsSpeedKey];
            break;
            
        case SECTION_VOLUME:
            self.volume = row;
            [defaults setInteger:row forKey:kUYLSettingsVolumeKey];
            break;
    }
    
    [self.tableView reloadData];
}

@end
