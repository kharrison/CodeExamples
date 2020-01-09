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

final class RootViewController: UIViewController {
    @IBOutlet var simpleButton: UIButton!
    @IBOutlet var embeddedButton: UIButton!

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "SimpleSegue"?:
            let simplePPC = segue.destination.popoverPresentationController
            simplePPC?.delegate = self
            simplePPC?.sourceView = simpleButton
            simplePPC?.sourceRect = simpleButton.bounds
        case "EmbeddedSegue"?:
            let embeddedPPC = segue.destination.popoverPresentationController
            embeddedPPC?.delegate = self
            embeddedPPC?.sourceView = embeddedButton
            embeddedPPC?.sourceRect = embeddedButton.bounds
        default:
            fatalError("Unknown segue: \(segue.identifier ?? "Unknown")")
        }
    }
}

// MARK: UIPopoverPresentationControllerDelegate

extension RootViewController: UIPopoverPresentationControllerDelegate {
    // In modal presentation we need to add a button to our popover
    // to allow it to be dismissed. Handle the situation where
    // our popover may be embedded in a navigation controller

    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        if style == .none {
            return controller.presentedViewController
        }

        let navigationController: UINavigationController = {
            guard let navigationController = controller.presentedViewController as? UINavigationController else {
                return UINavigationController(rootViewController: controller.presentedViewController)
            }
            return navigationController
        }()

        addDismissButton(navigationController)
        return navigationController
    }

    // Check for when we present in a non modal style and remove the
    // the dismiss button from the navigation bar.

    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
        if style == .none,
            let navController = presentationController.presentedViewController as? UINavigationController {
            removeDismissButton(navController)
        }
    }

    @objc private func didDismissPresentedView() {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }

    private func addDismissButton(_ navigationController: UINavigationController) {
        let rootViewController = navigationController.viewControllers[0]
        rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didDismissPresentedView))
    }

    private func removeDismissButton(_ navigationController: UINavigationController) {
        let rootViewController = navigationController.viewControllers[0]
        rootViewController.navigationItem.leftBarButtonItem = nil
    }
}
