//
//  MasterViewController.swift
//  Container
//
//  Created by Keith Harrison http://useyourloaf.com
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

final class MasterViewController: UIViewController {

    private let topStackView = UIStackView()

    private lazy var locationTableViewController: LocationTableViewController = self.buildFromStoryboard("Main")
    private lazy var mapViewController: MapViewController = self.buildFromStoryboard("Main")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()

        addContentController(locationTableViewController, to: topStackView)
        addContentController(mapViewController, to: topStackView)
        locationTableViewController.delegate = self
    }

    private var initialSetupDone = false

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if !initialSetupDone {
            // Set the initial stack view axis here when
            // we are sure the root view bounds are set.
            topStackView.axis = axisForSize(view.bounds.size)
            initialSetupDone = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        super.viewWillTransition(to: size, with: coordinator)
        topStackView.axis = axisForSize(size)
    }

    private func addContentController(_ child: UIViewController, to stackView: UIStackView) {

        addChild(child)
        stackView.addArrangedSubview(child.view)
        child.didMove(toParent: self)
    }

    private func removeContentController(_ child: UIViewController, from stackView: UIStackView) {

        child.willMove(toParent: nil)
        stackView.removeArrangedSubview(child.view)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }

    private func setupStackView() {

        topStackView.alignment = .fill
        topStackView.distribution = .fillEqually
        topStackView.spacing = 8.0

        topStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topStackView)

        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            topStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8.0),
            bottomLayoutGuide.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 8.0)
            ])
    }

    private func axisForSize(_ size: CGSize) -> NSLayoutConstraint.Axis {
        return size.width > size.height ? .horizontal : .vertical
    }

    private func buildFromStoryboard<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let identifier = String(describing: T.self)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Missing \(identifier) in Storyboard")
        }
        return viewController
    }
}

extension MasterViewController: LocationProviderDelegate {

    func didSelectLocation(_ location: Location) {
        mapViewController.coordinate = location.coordinate
    }
}
