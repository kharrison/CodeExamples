//
//  RemindMeViewController.swift
//  RemindMe
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

import UIKit
import UserNotifications

class RemindMeViewController: UIViewController {

    @IBOutlet private weak var reminderText: UITextField!
    @IBOutlet private weak var scheduleControl: UISegmentedControl!
    @IBOutlet private weak var datePicker: UIDatePicker!

    @IBAction private func scheduleNotification() {

        guard let body = reminderText.text, !body.isEmpty else {
            return
        }

        clearNotification()

        let content = UNMutableNotificationContent(body: body, title: "Don't forget")
        content.categoryIdentifier = UYLNotificationCategory.reminder.rawValue

        // If we want this notification to repeat starting at a future date we schedule
        // a non repeating notification at the initial fire date and include
        // the repeat interval in the userInfo of the content.

        if let interval = UYLNotificationRepeatInterval(index: scheduleControl.selectedSegmentIndex),
            interval != .none {
            let userInfo = [UYLNotificationUserDataKey.repeatInterval.rawValue : interval.rawValue]
            content.userInfo = userInfo
        }

        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UYLNotificationIdentifier.reminder.rawValue, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
            self.show(body: body, error: error)
            })
    }

    @IBAction private func clearNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        reminderText.resignFirstResponder()
    }

    private func show(body: String, error: Error?) {
        var alertController: UIAlertController
        let title = NSLocalizedString("Scheduled Reminder", comment: "Scheduled Reminder")
        if let error = error {
            alertController = UIAlertController(title: title, error: error)
        } else {
            alertController = UIAlertController(title: title, message: body)
        }

        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }

    private func dumpNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            for request in requests {
                print(request)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }

    private func setupInterface() {
        datePicker.minimumDate = Date()
    }
}

extension RemindMeViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
