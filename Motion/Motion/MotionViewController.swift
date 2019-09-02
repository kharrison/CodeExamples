//  MotionViewController.swift
//  Motion
//
// Created by Keith Harrison http://useyourloaf.com
// Copyright (c) 2014 Keith Harrison. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// Neither the name of Keith Harrison nor the names of its contributors
// may be used to endorse or promote products derived from this software
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

import UIKit

class MotionViewController: UIViewController {
    @IBOutlet private var pyramidView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "grid")!)

        var tilt: CGFloat = 50.0
        var view = pyramidView
        while view != nil {
            addHorizontalTilt(tilt, verticalTilt: tilt, to: view)
            tilt += 10
            view = view?.subviews.first
        }
    }

    func addHorizontalTilt(_ x: CGFloat, verticalTilt y: CGFloat, to view: UIView?) {
        var effects = [UIInterpolatingMotionEffect]()

        if x != 0 {
            let xAxis = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            xAxis.minimumRelativeValue = -x
            xAxis.maximumRelativeValue = x
            effects.append(xAxis)
        }

        if y != 0 {
            let yAxis = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            yAxis.minimumRelativeValue = -y
            yAxis.maximumRelativeValue = y
            effects.append(yAxis)
        }

        if !effects.isEmpty {
            let group = UIMotionEffectGroup()
            group.motionEffects = effects
            view?.addMotionEffect(group)
        }
    }
}
