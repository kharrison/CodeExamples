//
//  StackViewController.swift
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

class StackViewController: UIViewController {

  var heartTop: UIImageView?
  var starTop: UIImageView?
  var starBottomLeft: UIImageView?
  var heartBottom: UIImageView?
  var starBottomRight: UIImageView?

  let topStackView = UIStackView()
  let bottomStackView = UIStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
  }

  func setupViews() {

    topStackView.translatesAutoresizingMaskIntoConstraints = false
    topStackView.distribution = .EqualSpacing
    view.addSubview(topStackView)
    
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    bottomStackView.distribution = .EqualSpacing
    view.addSubview(bottomStackView)
    
    heartTop = topStackView.addImageViewForImage("Heart")
    starTop = topStackView.addImageViewForImage("Star")
  
    starBottomLeft = bottomStackView.addImageViewForImage("Star")
    heartBottom = bottomStackView.addImageViewForImage("Heart")
    starBottomRight = bottomStackView.addImageViewForImage("Star")
    
    // Set the vertical position of each stack view
    addConstraintFromView(topStackView, attribute: .CenterY, multiplier: 0.667, identifier: "topSV center Y")
    addConstraintFromView(bottomStackView, attribute: .CenterY, multiplier: 1.333, identifier: "bottomSV center Y")
    
    // Center both stack views
    addConstraintFromView(topStackView, attribute: .CenterX, multiplier: 1.0, identifier: "topSv center X")
    addConstraintFromView(bottomStackView, attribute: .CenterX, multiplier: 1.0, identifier: "bottomSV center X")
    
    // Set the widths of each stack view by constraining
    // the leading edge
    if let heartTop = heartTop {
      let offset = heartTop.bounds.width/2
      let constraint = NSLayoutConstraint(item: topStackView,
        attribute: .Leading,
        relatedBy: .Equal,
        toItem: view,
        attribute: .CenterXWithinMargins,
        multiplier: 0.5,
        constant: -offset)
      constraint.identifier = "TopStackLeading"
      view.addConstraint(constraint)
    }

    if let starBottomLeft = starBottomLeft {
      let offset = starBottomLeft.bounds.width/2
      let constraint = NSLayoutConstraint(item: bottomStackView,
        attribute: .Leading,
        relatedBy: .Equal,
        toItem: view,
        attribute: .CenterXWithinMargins,
        multiplier: 0.333,
        constant: -offset)
      constraint.identifier = "BottomStackLeading"
      view.addConstraint(constraint)
    }
  }
}