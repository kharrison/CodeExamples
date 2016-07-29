//
//  LayoutAnchorController.swift
//  AutoLayout
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

class LayoutAnchorController: UIViewController {

  let stackView = UIStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }
  
  func setupViews() {
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.distribution = .equalSpacing
    view.addSubview(stackView)
    
    stackView.addImageViewForImage("Heart")
    stackView.addImageViewForImage("Star")
    stackView.addImageViewForImage("Heart")
  
// Constraints to pin the stack view to the leading and trailing
// margins of the superview and below the top layout guide.
    
// The code below shows three different ways to achieve this:

// 1. Using the NSLayoutConstraint class method to create
//    each individual constraint. The most verbose of the
//    three approaches. 
//
//    NSLayoutConstraint(item: stackView,
//      attribute: .Leading,
//      relatedBy: .Equal,
//      toItem: view,
//      attribute: .LeadingMargin,
//      multiplier: 1,
//      constant: 0).active = true
//
//    NSLayoutConstraint(item: stackView,
//      attribute: .Trailing,
//      relatedBy: .Equal,
//      toItem: view,
//      attribute: .TrailingMargin,
//      multiplier: 1,
//      constant: 0).active = true
//
//    NSLayoutConstraint(item: stackView,
//      attribute: .Top,
//      relatedBy: .Equal,
//      toItem: topLayoutGuide,
//      attribute: .Bottom,
//      multiplier: 1,
//      constant: 8.0).active = true
    
// 2. Using the Visual Format Language to add both constraints
//    in one go. Shorter but still not very readable.

//    let views: [String: AnyObject] =
//      ["stackView" : stackView,
//       "topLayoutGuide" : topLayoutGuide]
//    
//    let h = NSLayoutConstraint.constraintsWithVisualFormat(
//      "|-[stackView]-|",
//      options: [],
//      metrics: nil,
//      views: views)
//    NSLayoutConstraint.activateConstraints(h)
//    
//    let v = NSLayoutConstraint.constraintsWithVisualFormat(
//      "V:|[topLayoutGuide]-[stackView]",
//      options: [],
//      metrics: nil,
//      views: views)
//    NSLayoutConstraint.activateConstraints(v)
    
// 3. Using layout anchors - by far the easiest method but requires
//    iOS 9.

    let margins = view.layoutMarginsGuide
    
    stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true
  }
}
