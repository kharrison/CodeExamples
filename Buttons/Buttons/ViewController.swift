//
//  ViewController.swift
//  Buttons
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

class ViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a custom button and set title label style
        
        let orangeButton = UIButton(type: .Custom)
        orangeButton.setTitle("Orange", forState: .Normal)
        orangeButton.setTitleColor(.orangeColor(), forState: .Normal)
        orangeButton.setTitleColor(.whiteColor(), forState: .Highlighted)
        orangeButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        orangeButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)

        // Get the pre-sliced template images direct from the
        // asset catalog for the default and hightlighted states
        
        let slicedBorderTemplate = UIImage(named: "slicedBorderTemplate")
        let slicedFillTemplate = UIImage(named: "slicedFillTemplate")
        
        orangeButton.setBackgroundImage(slicedBorderTemplate, forState: .Normal)
        orangeButton.setBackgroundImage(slicedFillTemplate, forState: .Highlighted)
        
        // The tintColor controls the colour used by the template images
        // Defaults to inherited value
        
        orangeButton.tintColor = .orangeColor()
        
        stackView.addArrangedSubview(orangeButton)
    }
}