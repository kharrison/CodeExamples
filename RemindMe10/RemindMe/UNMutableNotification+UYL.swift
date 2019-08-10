//
//  UNMutableNotification+UYL.swift
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

extension UNMutableNotificationContent {

    /// Create editable content for a user notification. This
    /// is a convenience initializer for a simple notification
    /// containing a title, body and default sound.
    ///
    /// - parameters:
    ///   - body: The message displayed in the notification alert.
    ///   - title: A short description of the reason for the alert.
    ///   - sound: The sound to play when the notification is
    ///            delivered. Defaults to `UNNotificationSound.default()`.

    convenience init(body: String, title: String, sound: UNNotificationSound = UNNotificationSound.default) {
        self.init()
        self.title = NSString.localizedUserNotificationString(forKey: title, arguments: nil)
        self.body = body
        self.sound = sound
    }

    /// Create editiable content for a user notification
    /// from the content of an existing notification.
    ///
    /// - parameters:
    ///   - content: The content of a local or remote
    ///              notification.
    
    convenience init(content: UNNotificationContent) {
        self.init()
        self.title = content.title
        self.subtitle = content.subtitle
        self.body = content.body
        self.sound = content.sound
        self.badge = content.badge
        self.launchImageName = content.launchImageName
        self.categoryIdentifier = content.categoryIdentifier
        self.threadIdentifier = content.threadIdentifier
    }
}

