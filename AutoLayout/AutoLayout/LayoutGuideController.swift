//
//  LayoutGuideController.swift
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

class LayoutGuideController: UIViewController {

    // Use layout guides as an alternative to spacer views
    // The two buttons will be placed between the view margins
    // with equal spacing between the buttons and the margins
    // so that the width of the three guides is equal.
    
    // =  |+++++++++++************+++++++++++************+++++++++++| =
    // =  |+ leading +*    no    *+  middle +*   yes    *+ trailing+| =
    // =  |+  guide  +*  button  *+  guide  +*  button  *+  guide  +| =
    // =  |+++++++++++************+++++++++++************+++++++++++| =
    
    let leadingGuide = UILayoutGuide()
    let noButton = UIButton(type: .Custom)
    let middleGuide = UILayoutGuide()
    let yesButton = UIButton(type: .Custom)
    let trailingGuide = UILayoutGuide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        
        // Configure the buttons and add them to the superview
        
        noButton.translatesAutoresizingMaskIntoConstraints = false
        noButton.setTitle("No", forState: .Normal)
        let redImage = UIImage(named: "redButton")
        noButton.setBackgroundImage(redImage, forState: .Normal)
        noButton.contentEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 16)
        let noThanksAction = #selector(LayoutGuideController.noThanks(_:))
        noButton.addTarget(self, action: noThanksAction, forControlEvents: .TouchUpInside)
      
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        yesButton.setTitle("Yes please!", forState: .Normal)
        let greenImage = UIImage(named: "greenButton")
        yesButton.setBackgroundImage(greenImage, forState: .Normal)
        yesButton.contentEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 16)
        let yesPleaseAction = #selector(LayoutGuideController.yesPlease(_:))
        yesButton.addTarget(self, action: yesPleaseAction, forControlEvents: .TouchUpInside)
        
        view.addSubview(noButton)
        view.addSubview(yesButton)
        
        // Add the layout guides to the view
        // Note that the guides are not part of the
        // view hierarchy
        
        view.addLayoutGuide(leadingGuide)
        view.addLayoutGuide(middleGuide)
        view.addLayoutGuide(trailingGuide)
    }
    
    private func setupConstraints() {
        
        // The views are spaced relative to the margings of
        // the superview. To space the views relative to the
        // edges of the super view replace "margings" with
        // "view" in the constraints below
        
        let margins = view.layoutMarginsGuide
        
        // leading to trailing constraints
        // working from left to right
        
        margins.leadingAnchor.constraintEqualToAnchor(leadingGuide.leadingAnchor).active = true
        leadingGuide.trailingAnchor.constraintEqualToAnchor(noButton.leadingAnchor).active = true
        noButton.trailingAnchor.constraintEqualToAnchor(middleGuide.leadingAnchor).active = true
        middleGuide.trailingAnchor.constraintEqualToAnchor(yesButton.leadingAnchor).active = true
        yesButton.trailingAnchor.constraintEqualToAnchor(trailingGuide.leadingAnchor).active = true
        trailingGuide.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        
        // The buttons should have the same width
        noButton.widthAnchor.constraintEqualToAnchor(yesButton.widthAnchor).active = true
        
        // The guides should have the same width
        leadingGuide.widthAnchor.constraintEqualToAnchor(middleGuide.widthAnchor).active = true
        leadingGuide.widthAnchor.constraintEqualToAnchor(trailingGuide.widthAnchor).active = true
    
        // Center everything vertically in the super view
        leadingGuide.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        middleGuide.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        trailingGuide.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        noButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        yesButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
    }
    
    func noThanks(sender: UIButton) {
        print("No thanks!")
    }
  
    func yesPlease(sender: UIButton) {
        print("Yes please!")
    }
}
