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
    let redButton = UIButton(type: .custom)
    let middleGuide = UILayoutGuide()
    let greenButton = UIButton(type: .custom)
    let trailingGuide = UILayoutGuide()
    
    var compactConstraints = [NSLayoutConstraint]()
    var regularConstraints = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
            enableConstraintsForWidth(traitCollection.horizontalSizeClass)
        }
    }
    
    private func setupViews() {

        textLabel.text = "Vertically align for compact widths"
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        textLabel.textColor = .gray
        
        redButton.translatesAutoresizingMaskIntoConstraints = false
        redButton.setTitle("No don't do it", for: UIControl.State())
        let redImage = UIImage(named: "redButton")
        redButton.setBackgroundImage(redImage, for: UIControl.State())
        redButton.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        let noAction = #selector(noAction(_:))
        redButton.addTarget(self, action: noAction, for: .touchUpInside)
        
        greenButton.translatesAutoresizingMaskIntoConstraints = false
        greenButton.setTitle("Start the Countdown!!!", for: UIControl.State())
        let greenImage = UIImage(named: "greenButton")
        greenButton.setBackgroundImage(greenImage, for: UIControl.State())
        greenButton.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        let yesAction = #selector(yesAction(_:))
        greenButton.addTarget(self, action: yesAction, for: .touchUpInside)

        view.addSubview(textLabel)
        view.addSubview(redButton)
        view.addSubview(greenButton)
        view.addLayoutGuide(leadingGuide)
        view.addLayoutGuide(middleGuide)
        view.addLayoutGuide(trailingGuide)
    }

    private var firstTime = true
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if firstTime {
            firstTime = false
            enableConstraintsForWidth(traitCollection.horizontalSizeClass)
        }
    }

    private func setupConstraints() {
        
        // =========================================
        // common constraints, activate immediately.
        // =========================================
        
        let contentGuide = view.readableContentGuide
        textLabel.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0).isActive = true

        redButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8.0).isActive = true
        redButton.widthAnchor.constraint(equalTo: greenButton.widthAnchor).isActive = true
       
        leadingGuide.widthAnchor.constraint(equalTo: middleGuide.widthAnchor).isActive = true
        leadingGuide.widthAnchor.constraint(equalTo: trailingGuide.widthAnchor).isActive = true

        view.leadingAnchor.constraint(equalTo: leadingGuide.leadingAnchor).isActive = true
        trailingGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

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
        
        regularConstraints.append(leadingGuide.trailingAnchor.constraint(equalTo: redButton.leadingAnchor))
        regularConstraints.append(redButton.trailingAnchor.constraint(equalTo: middleGuide.leadingAnchor))
        regularConstraints.append(middleGuide.trailingAnchor.constraint(equalTo: greenButton.leadingAnchor))
        regularConstraints.append(greenButton.trailingAnchor.constraint(equalTo: trailingGuide.leadingAnchor))
        regularConstraints.append(greenButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8.0))

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

        compactConstraints.append(redButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        compactConstraints.append(greenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        compactConstraints.append(greenButton.topAnchor.constraint(equalTo: redButton.bottomAnchor, constant: 8.0))
    }
    
    private func enableConstraintsForWidth(_ horizontalSizeClass: UIUserInterfaceSizeClass) {
        if horizontalSizeClass == .regular {
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        } else {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(compactConstraints)
        }
    }
    
    @objc func noAction(_ sender: UIButton) {
        print("No")
    }
    
    @objc func yesAction(_ sender: UIButton) {
        print("Yes")
    }
}
