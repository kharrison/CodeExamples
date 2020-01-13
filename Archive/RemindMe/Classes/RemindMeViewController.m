//
//  RemindMeViewController.m
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2016 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

#import "RemindMeViewController.h"

@interface RemindMeViewController () <UITextFieldDelegate>
@property (nonatomic,strong) IBOutlet UITextField *reminderText;
@property (nonatomic,strong) IBOutlet UISegmentedControl *scheduleControl;
@property (nonatomic,strong) IBOutlet UIButton *setButton;
@property (nonatomic,strong) IBOutlet UIButton *clearButton;
@property (nonatomic,strong) IBOutlet UIDatePicker *datePicker;
@end

@implementation RemindMeViewController

NSString *kRemindMeNotificationDataKey = @"kRemindMeNotificationDataKey";

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.datePicker.minimumDate = [NSDate date];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}

- (IBAction)clearNotification {
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (IBAction)scheduleNotification {
	[self.reminderText resignFirstResponder];
	[[UIApplication sharedApplication] cancelAllLocalNotifications];

    UILocalNotification *notif = [[UILocalNotification alloc] init];
    notif.fireDate = [self.datePicker date];
    notif.timeZone = [NSTimeZone defaultTimeZone];
    
    notif.alertBody = NSLocalizedString(@"AlertBody",@"Did you forget something?");
    notif.alertAction = NSLocalizedString(@"AlertAction",@"Show me");
    notif.soundName = UILocalNotificationDefaultSoundName;
    notif.applicationIconBadgeNumber = 1;

    NSInteger index = [self.scheduleControl selectedSegmentIndex];
    switch (index)
    {
        case 1:
            notif.repeatInterval = NSCalendarUnitMinute;
            break;
        case 2:
            notif.repeatInterval = NSCalendarUnitHour;
            break;
        case 3:
            notif.repeatInterval = NSCalendarUnitDay;
            break;
        case 4:
            notif.repeatInterval = NSCalendarUnitMonth;
            break;
        default:
            notif.repeatInterval = 0;
            break;
    }
		
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:self.reminderText.text
                                            forKey:kRemindMeNotificationDataKey];
    notif.userInfo = userDict;
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
}

- (void)showReminder:(UILocalNotification *)notification {
    NSString *reminderText = [notification.userInfo objectForKey:kRemindMeNotificationDataKey];
    if (reminderText) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Reminder" message:reminderText preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK",@"OK") style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
