//
//  AdaptiveViewController.swift
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

class AdaptiveViewController: UIViewController {

    let textLabel = UILabel()
    let leadingGuide = UILayoutGuide()
    let redButton = UIButton(type: .Custom)
    let middleGuide = UILayoutGuide()
    let greenButton = UIButton(type: .Custom)
    let trailingGuide = UILayoutGuide()
    
    var compactConstraints = [NSLayoutConstraint]()
    var regularConstraints = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            enableConstraintsForWidth(traitCollection.horizontalSizeClass)
        }
    }
    
    private func setupViews() {

        textLabel.text = "Vertically align for compact widths"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .Center
        textLabel.textColor = .grayColor()
        
        redButton.translatesAutoresizingMaskIntoConstraints = false
        redButton.setTitle("No don't do it", forState: .Normal)
        let redImage = UIImage(named: "redButton")
        redButton.setBackgroundImage(redImage, forState: .Normal)
        redButton.contentEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 16)
        let noAction = #selector(noAction(_:))
        redButton.addTarget(self, action: noAction, forControlEvents: .TouchUpInside)
        
        greenButton.translatesAutoresizingMaskIntoConstraints = false
        greenButton.setTitle("Start the Countdown!!!", forState: .Normal)
        let greenImage = UIImage(named: "greenButton")
        greenButton.setBackgroundImage(greenImage, forState: .Normal)
        greenButton.contentEdgeInsets = UIEdgeInsetsMake(8, 16, 8, 16)
        let yesAction = #selector(yesAction(_:))
        greenButton.addTarget(self, action: yesAction, forControlEvents: .TouchUpInside)

        view.addSubview(textLabel)
        view.addSubview(redButton)
        view.addSubview(greenButton)
        view.addLayoutGuide(leadingGuide)
        view.addLayoutGuide(middleGuide)
        view.addLayoutGuide(trailingGuide)
    }
    
    private func setupConstraints() {
        
        // =========================================
        // common constraints, activate immediately.
        // =========================================
        
        let contentGuide = view.readableContentGuide
        textLabel.leadingAnchor.constraintEqualToAnchor(contentGuide.leadingAnchor).active = true
        textLabel.trailingAnchor.constraintEqualToAnchor(contentGuide.trailingAnchor).active = true
        textLabel.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8.0).active = true

        redButton.topAnchor.constraintEqualToAnchor(textLabel.bottomAnchor, constant: 8.0).active = true
        redButton.widthAnchor.constraintEqualToAnchor(greenButton.widthAnchor).active = true
       
        leadingGuide.widthAnchor.constraintEqualToAnchor(middleGuide.widthAnchor).active = true
        leadingGuide.widthAnchor.constraintEqualToAnchor(trailingGuide.widthAnchor).active = true

        view.leadingAnchor.constraintEqualToAnchor(leadingGuide.leadingAnchor).active = true
        trailingGuide.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true

        // =========================================
        // regular width constraints
        // =========================================

        // =  |---------------------------------------------------------| =
        // =  |                      ************                       | =
        // =  |                      *textLabel *                       | =
        // =  |                      ************                       | =
        // =  |+++++++++++************+++++++++++************+++++++++++| =
        // =  |+ leading +*   red    *+  middle +*  green   *+ trailing+| =
        // =  |+  guide  +*  button  *+  guide  +*  button  *+  guide  +| =
        // =  |+++++++++++************+++++++++++************+++++++++++| =
        
        regularConstraints.append(leadingGuide.trailingAnchor.constraintEqualToAnchor(redButton.leadingAnchor))
        regularConstraints.append(redButton.trailingAnchor.constraintEqualToAnchor(middleGuide.leadingAnchor))
        regularConstraints.append(middleGuide.trailingAnchor.constraintEqualToAnchor(greenButton.leadingAnchor))
        regularConstraints.append(greenButton.trailingAnchor.constraintEqualToAnchor(trailingGuide.leadingAnchor))
        regularConstraints.append(greenButton.topAnchor.constraintEqualToAnchor(textLabel.bottomAnchor, constant: 8.0))

        // =========================================
        // compact width constraints
        // =========================================

        // =  |---------------------------------------------------------| =
        // =  |                      ************                       | =
        // =  |                      *textLabel *                       | =
        // =  |                      ************                       | =
        // =  |                      ************                       | =
        // =  |                      *   red    *                       | =
        // =  |                      *  button  *                       | =
        // =  |                      ************                       | =
        // =  |                      ************                       | =
        // =  |                      *  green   *                       | =
        // =  |                      *  button  *                       | =
        // =  |                      ************                       | =
        // =  |+++++++++++************+++++++++++************+++++++++++| =

        compactConstraints.append(redButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        compactConstraints.append(greenButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor))
        compactConstraints.append(greenButton.topAnchor.constraintEqualToAnchor(redButton.bottomAnchor, constant: 8.0))
        
        enableConstraintsForWidth(traitCollection.horizontalSizeClass)
    }
    
    private func enableConstraintsForWidth(horizontalSizeClass: UIUserInterfaceSizeClass) {
        if horizontalSizeClass == .Regular {
            NSLayoutConstraint.deactivateConstraints(compactConstraints)
            NSLayoutConstraint.activateConstraints(regularConstraints)
        } else {
            NSLayoutConstraint.deactivateConstraints(regularConstraints)
            NSLayoutConstraint.activateConstraints(compactConstraints)
        }
    }
    
    func noAction(sender: UIButton) {
        print("No")
    }
    
    func yesAction(sender: UIButton) {
        print("Yes")
    }
}