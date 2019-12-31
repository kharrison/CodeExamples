//  Created by Keith Harrison https://useyourloaf.com
//  Copyright (c) 2017 Keith Harrison. All rights reserved.
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

class ViewController: UIViewController {
    @IBOutlet private var fullScreenConstraints: [NSLayoutConstraint]!
    @IBOutlet private var halfScreenConstraints: [NSLayoutConstraint]!
    @IBOutlet private var modeSwitch: UISwitch!
    @IBOutlet private var countDisplay: UILabel!

    override var prefersStatusBarHidden: Bool {
        if #available(iOS 11.0, *) {
            return super.prefersStatusBarHidden
        } else {
            return fullScreenMode || super.prefersStatusBarHidden
        }
    }

    override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        return fullScreenMode ? [.bottom, .top] : UIRectEdge()
    }

    private var count = 0 {
        didSet {
            countDisplay.text = NumberFormatter.localizedString(from: NSNumber(value: count), number: .decimal)
        }
    }

    private var fullScreenMode: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    private func updateAppearance() {
        view.layoutIfNeeded()
        updateConstraints()
        UIView.animate(withDuration: 0.25) {
            self.updateDeferringSystemGestures()
            self.view.layoutIfNeeded()
        }
    }

    private func updateDeferringSystemGestures() {
        if #available(iOS 11.0, *) {
            setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
        } else {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    private func updateConstraints() {
        if fullScreenMode {
            halfScreenConstraints.forEach { $0.isActive = false }
            fullScreenConstraints.forEach { $0.isActive = true }
        } else {
            fullScreenConstraints.forEach { $0.isActive = false }
            halfScreenConstraints.forEach { $0.isActive = true }
        }
    }

    @IBAction func fullScreen(_ sender: UISwitch) {
        fullScreenMode = sender.isOn
    }

    @IBAction func swipeUp(_ sender: UISwipeGestureRecognizer) {
        count += 1
    }

    @IBAction func swipeDown(_ sender: UISwipeGestureRecognizer) {
        count -= 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        modeSwitch.isOn = fullScreenMode
        updateAppearance()
    }
}
