//
//  MarginViewController.swift
//  Margins
//
//  Created by Keith Harrison https://useyourloaf.com
//  Copyright (c) 2017 Keith Harrison. All rights reserved.
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

public class MarginViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    public lazy var redView: UIView = {
        return self.simpleView(color: .red)
    }()

    public lazy var stackView: UIStackView = {
        return UIStackView()
    }()

    private func setupViews() {
        view.addSubview(redView)
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            redView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])

        let yellowView = simpleView(color: .yellow)
        redView.addSubview(yellowView)
        let redMargins = redView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            yellowView.leadingAnchor.constraint(equalTo: redMargins.leadingAnchor),
            yellowView.trailingAnchor.constraint(equalTo: redMargins.trailingAnchor),
            yellowView.topAnchor.constraint(equalTo: redMargins.topAnchor),
            yellowView.bottomAnchor.constraint(equalTo: redMargins.bottomAnchor)
            ])

        let blueView = simpleView(color: .blue)
        stackView.addArrangedSubview(blueView)
        let greenView = simpleView(color: .green)
        stackView.addArrangedSubview(greenView)
        stackView.spacing = 8.0
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: redView.bottomAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            stackView.heightAnchor.constraint(equalTo: redView.heightAnchor)
            ])
    }

    private func simpleView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = color
        return view
    }
}

