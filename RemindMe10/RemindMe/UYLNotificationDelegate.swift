//
//  UYLNotificationDelegate.swift
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

import UserNotifications

enum UYLNotificationIdentifier: String {
    case reminder
}

enum UYLNotificationUserDataKey: String {
    case repeatInterval
}

enum UYLNotificationRepeatInterval: String {
    case none
    case minute
    case hour
    case day
    case week

    init?(index: Int) {
        switch index {
        case 0: self = .none
        case 1: self = .minute
        case 2: self = .hour
        case 3: self = .day
        case 4: self = .week
        default: return nil
        }
    }
}

enum UYLNotificationAction: String {
    case snooze = "com.useyourloaf.actionSnooze"
    case delete = "com.useyourloaf.actionDelete"
}

enum UYLNotificationCategory: String {
    case reminder = "com.useyourloaf.reminder"
}

class UYLNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        rescheduleRepeating(notification: notification)
        completionHandler([.alert,.sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default Action")
        case UYLNotificationAction.snooze.rawValue:
            print("Snooze")
        case UYLNotificationAction.delete.rawValue:
            print("Delete")
            let identifier = response.notification.request.identifier
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
            break
        default:
            rescheduleRepeating(notification: response.notification)
        }
        completionHandler()
    }

    func registerCategories() {
        let snoozeAction = UNNotificationAction(identifier: UYLNotificationAction.snooze.rawValue, title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: UYLNotificationAction.delete.rawValue, title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: UYLNotificationCategory.reminder.rawValue, actions: [snoozeAction,deleteAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }

    private func rescheduleRepeating(notification: UNNotification) {

        let userInfo = notification.request.content.userInfo
        let repeatKey = UYLNotificationUserDataKey.repeatInterval.rawValue

        guard let identifier = UYLNotificationIdentifier(rawValue: notification.request.identifier),
            identifier == .reminder,
            let repeatIntervalRawValue = userInfo[repeatKey] as? String,
            let repeatInterval = UYLNotificationRepeatInterval(rawValue: repeatIntervalRawValue),
            repeatInterval != .none else {
            return
        }

        let triggerDate = Calendar.current.dateComponents([.weekday,.day,.hour,.minute], from: notification.date)

        var date = DateComponents()
        switch repeatInterval {
        case .minute:
            date.second = 0
        case .hour:
            date.minute = triggerDate.minute
        case .day:
            date.hour = triggerDate.hour
            date.minute = triggerDate.minute
        case .week:
            date.weekday = triggerDate.weekday
            date.hour = triggerDate.hour
            date.minute = triggerDate.minute
        case .none:
            return
        }

        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        let content = UNMutableNotificationContent(content: notification.request.content)
        let request = UNNotificationRequest(identifier: UYLNotificationIdentifier.reminder.rawValue, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}
