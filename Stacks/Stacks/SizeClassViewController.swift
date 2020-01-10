//
//  SizeClassViewController.swift
//  Stacks
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

final class SizeClassViewController: UIViewController {
    @IBOutlet private var stackView: UIStackView!
    
    // The alignment axis of the stack view should be set correctly in the Storyboard
    // for the given size classes. It should be horizontal except for when the view
    // has a compact width and a regular height. This did not work in early iOS 9 
    // beta releases. It was fixed in iOS 9 beta 4.
    
    // The following code was a workaround to the bug that was fixed in iOS 9 beta 4.
    // Uncomment if you want to change the stack view axis when the view changes
    // size (you can then remove the size class constraints from the stack view in
    // the Storyboard).
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViewForSize(view.bounds.size)
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        configureViewForSize(size)
//    }
//
//    private func configureViewForSize(_ size: CGSize) {
//        if size.width > size.height {
//            stackView.axis = .horizontal
//        } else {
//            stackView.axis = .vertical
//        }
//    }
}
