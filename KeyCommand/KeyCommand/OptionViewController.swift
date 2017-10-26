//
//  OptionViewController.swift
//  KeyCommand
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

class OptionViewController: UIViewController {

    private enum InputKey: String {
        case low = "1"
        case medium = "2"
        case high = "3"
    }

    // Override keyCommands and return the three
    // key commands for this view controller.

    override var keyCommands: [UIKeyCommand]? {
        return [
        UIKeyCommand(input: InputKey.low.rawValue,
                     modifierFlags: .command,
                     action: #selector(OptionViewController.performCommand(sender:)),
                     discoverabilityTitle: NSLocalizedString("LowPriority", comment: "Low priority")),

        UIKeyCommand(input: InputKey.medium.rawValue,
                     modifierFlags: .command,
                     action: #selector(OptionViewController.performCommand(sender:)),
                     discoverabilityTitle: NSLocalizedString("MediumPriority", comment: "Medium priority")),

        UIKeyCommand(input: InputKey.high.rawValue,
                     modifierFlags: .command,
                     action: #selector(OptionViewController.performCommand(sender:)),
                     discoverabilityTitle: NSLocalizedString("HighPriority", comment: "High priority"))
        ]
    }

    @objc func performCommand(sender: UIKeyCommand) {
        guard let key = InputKey(rawValue: sender.input!) else {
            return
        }
        switch key {
        case .low: performSegue(withIdentifier: .low, sender: self)
        case .medium: performSegue(withIdentifier: .medium, sender: self)
        case .high: performSegue(withIdentifier: .high, sender: self)
        }
    }

// You can also add key commands without overriding the
// keyCommands property. For example you could call the
// following function from viewDidLoad:

//    private func setupCommands() {
//        let lowCommand = UIKeyCommand(input: InputKey.low.rawValue,
//                                      modifierFlags: .command,
//                                      action: #selector(OptionViewController.performCommand(sender:)),
//                                      discoverabilityTitle: NSLocalizedString("LowPriority", comment: "Low priority"))
//        addKeyCommand(lowCommand)
//
//        let mediumCommand = UIKeyCommand(input: InputKey.medium.rawValue,
//                                         modifierFlags: .command,
//                                         action: #selector(OptionViewController.performCommand(sender:)),
//                                         discoverabilityTitle: NSLocalizedString("MediumPriority", comment: "Medium priority"))
//        addKeyCommand(mediumCommand)
//
//        let highCommand = UIKeyCommand(input: InputKey.high.rawValue,
//                                       modifierFlags: .command,
//                                       action: #selector(OptionViewController.performCommand(sender:)),
//                                       discoverabilityTitle: NSLocalizedString("HighPriority", comment: "High priority"))
//        addKeyCommand(highCommand)
//    }
}

extension OptionViewController: SegueHandlerType {

    enum SegueIdentifier: String {
        case low
        case medium
        case high
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? DetailViewController else {
            fatalError("Expected embedded DetailViewController")
        }

        switch segueIdentifierForSegue(segue: segue) {
        case .low:
            viewController.priority = .low
        case .medium:
            viewController.priority = .medium
        case .high:
            viewController.priority = .high
        }
    }
}
