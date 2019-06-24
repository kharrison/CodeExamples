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
    let noButton = UIButton(type: .custom)
    let middleGuide = UILayoutGuide()
    let yesButton = UIButton(type: .custom)
    let trailingGuide = UILayoutGuide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        
        // Configure the buttons and add them to the superview
        
        noButton.translatesAutoresizingMaskIntoConstraints = false
        noButton.setTitle("No", for: UIControl.State())
        let redImage = UIImage(named: "redButton")
        noButton.setBackgroundImage(redImage, for: UIControl.State())
        noButton.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        let noThanksAction = #selector(LayoutGuideController.noThanks(_:))
        noButton.addTarget(self, action: noThanksAction, for: .touchUpInside)
      
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        yesButton.setTitle("Yes please!", for: UIControl.State())
        let greenImage = UIImage(named: "greenButton")
        yesButton.setBackgroundImage(greenImage, for: UIControl.State())
        yesButton.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        let yesPleaseAction = #selector(LayoutGuideController.yesPlease(_:))
        yesButton.addTarget(self, action: yesPleaseAction, for: .touchUpInside)
        
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
        
        margins.leadingAnchor.constraint(equalTo: leadingGuide.leadingAnchor).isActive = true
        leadingGuide.trailingAnchor.constraint(equalTo: noButton.leadingAnchor).isActive = true
        noButton.trailingAnchor.constraint(equalTo: middleGuide.leadingAnchor).isActive = true
        middleGuide.trailingAnchor.constraint(equalTo: yesButton.leadingAnchor).isActive = true
        yesButton.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor).isActive = true
        trailingGuide.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        // The buttons should have the same width
        noButton.widthAnchor.constraint(equalTo: yesButton.widthAnchor).isActive = true
        
        // The guides should have the same width
        leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor).isActive = true
        leadingGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor).isActive = true
    
        // Center everything vertically in the super view
        leadingGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        middleGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        trailingGuide.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        yesButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func noThanks(_ sender: UIButton) {
        print("No thanks!")
    }
  
    @objc func yesPlease(_ sender: UIButton) {
        print("Yes please!")
    }
}
