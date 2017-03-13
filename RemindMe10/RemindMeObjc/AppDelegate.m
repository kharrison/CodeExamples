//
//  AppDelegate.m
//  RemindMeObjc
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

@import UserNotifications;

#import "AppDelegate.h"
#import "UYLNotificationDelegate.h"

@interface AppDelegate ()
@property (nonatomic,strong) id<UNUserNotificationCenterDelegate> notificationDelegate;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerForLocalNotifications];
    self.notificationDelegate = [UYLNotificationDelegate new];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self.notificationDelegate;
    return YES;
}

- (void)registerForLocalNotifications {

    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    UNUserNotificationCenter *center = UNUserNotificationCenter.currentNotificationCenter;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"Something went wrong");
        }
    }];

    UNNotificationAction *snoozeAction = [UNNotificationAction actionWithIdentifier:@"Snooze" title:@"Snooze" options:UNNotificationActionOptionNone];
    UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:@"Delete" title:@"Delete" options:UNNotificationActionOptionDestructive];

    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"UYLReminderCategory" actions:@[snoozeAction,deleteAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    NSSet *categories = [NSSet setWithObject:category];
    [center setNotificationCategories:categories];

//    let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
//    let deleteAction = UNNotificationAction(identifier: UYLNotificationAction.delete.rawValue, title: "Delete", options: [.destructive])
//    let category = UNNotificationCategory(identifier: UYLNotificationCategory.reminder.rawValue, actions: [snoozeAction,deleteAction], intentIdentifiers: [], options: [])
//    UNUserNotificationCenter.current().setNotificationCategories([category])

}
@end
