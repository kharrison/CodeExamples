//
//  CenterAlignViewController.swift
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

class CenterAlignViewController: UIViewController {

    var heartTop: UIImageView?
    var starTop: UIImageView?
    var starBottomLeft: UIImageView?
    var heartBottom: UIImageView?
    var starBottomRight: UIImageView?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        heartTop = addImageViewForImageNamed("Heart")
        starTop = addImageViewForImageNamed("Star")
        starBottomLeft = addImageViewForImageNamed("Star")
        heartBottom = addImageViewForImageNamed("Heart")
        starBottomRight = addImageViewForImageNamed("Star")
        setupConstraints()
    }
  
    func setupConstraints() {
        addConstraintFromView(heartTop, attribute: .CenterY, multiplier: 0.667, identifier: "heartTop center Y")
        addConstraintFromView(starTop, attribute: .CenterY, multiplier: 0.667, identifier: "starTop center Y")
    
        addConstraintFromView(heartTop, attribute: .CenterX, multiplier: 0.5, identifier: "heartTop center X")
        addConstraintFromView(starTop, attribute: .CenterX, multiplier: 1.5, identifier: "starTop center X")
    
    
        addConstraintFromView(starBottomLeft, attribute: .CenterY, multiplier: 1.333, identifier: "startBottomLeft center Y")
        addConstraintFromView(heartBottom, attribute: .CenterY, multiplier: 1.333, identifier: "heartBottom center Y")
        addConstraintFromView(starBottomRight, attribute: .CenterY, multiplier: 1.333, identifier: "starBottomRight center Y")
    
        addConstraintFromView(starBottomLeft, attribute: .CenterX, multiplier: 0.333, identifier: "starBottomLeft center X")
        addConstraintFromView(heartBottom, attribute: .CenterX, multiplier: 1.0, identifier: "heartBottom center X")
        addConstraintFromView(starBottomRight, attribute: .CenterX, multiplier: 1.667, identifier: "starBottomRight center X")
    }
}

extension UIViewController {
  
    func addImageViewForImageNamed(name: String) -> UIImageView? {
        if let image = UIImage(named: name) {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            return imageView
        }
        return nil
    }
  
    func addConstraintFromView(subview: UIView?, attribute: NSLayoutAttribute, multiplier: CGFloat, identifier: String) {
        if let subview = subview {
            let constraint = NSLayoutConstraint.init(item: subview,
                attribute: attribute,
                relatedBy: .Equal,
                toItem: view,
                attribute: attribute,
                multiplier: multiplier,
                constant: 0)
            constraint.identifier = identifier
            view.addConstraint(constraint)
        }
    }
}
