//
//  RootViewController.swift
//  AdaptivePopover
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2015 Keith Harrison. All rights reserved.
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

class RootViewController: UIViewController {

    @IBOutlet weak var simpleButton: UIButton!
    @IBOutlet weak var embeddedButton: UIButton!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case "SimpleSegue"?:
            let simplePPC = segue.destinationViewController.popoverPresentationController
            simplePPC?.delegate = self
            simplePPC?.sourceView = simpleButton
            simplePPC?.sourceRect = simpleButton.bounds
        case "EmbeddedSegue"?:
            let embeddedPPC = segue.destinationViewController.popoverPresentationController
            embeddedPPC?.delegate = self
            embeddedPPC?.sourceView = embeddedButton
            embeddedPPC?.sourceRect = embeddedButton.bounds
        default:
            fatalError("Unknown segue: \(segue.identifier)")
        }
    }
}


// MARK: UIPopoverPresentationControllerDelegate
extension RootViewController: UIPopoverPresentationControllerDelegate {
    
    // In modal presentation we need to add a button to our popover
    // to allow it to be dismissed. Handle the situation where
    // our popover may be embedded in a navigation controller
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        guard style != .None else {
            return controller.presentedViewController
        }
        
        if let navController = controller.presentedViewController as? UINavigationController {
            addDismissButton(navController)
            return navController
        } else {
            let navController = UINavigationController.init(rootViewController: controller.presentedViewController)
            addDismissButton(navController)
            return navController
        }
    }
    
    // Check for when we present in a non modal style and remove the
    // the dismiss button from the navigation bar.
    
//    func presentationController(presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
//        if style == .None {
//            if let navController = presentationController.presentedViewController as? UINavigationController {
//                removeDismissButton(navController)
//            }
//        }
//    }
    
    func didDismissPresentedView() {
        presentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func addDismissButton(navigationController: UINavigationController) {
        let rootViewController = navigationController.viewControllers[0]
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .Done,
            target: self, action: "didDismissPresentedView")
    }
    
    private func removeDismissButton(navigationController: UINavigationController) {
        let rootViewController = navigationController.viewControllers[0]
        rootViewController.navigationItem.leftBarButtonItem = nil;
    }
}
