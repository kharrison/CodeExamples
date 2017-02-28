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

class MasterViewController: UIViewController {

    @IBOutlet private weak var topStackView: UIStackView!
    fileprivate var locationTableViewController: LocationTableViewController?
    fileprivate var mapViewController: MapViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let locationController = childViewControllers.first as? LocationTableViewController else {
//            fatalError("Check storyboard for missing LocationTableViewController")
//        }
//
//        guard let mapController = childViewControllers.last as? MapViewController else {
//            fatalError("Check storyboard for missing MapViewController")
//        }
//
//        locationTableViewController = locationController
//        mapViewController = mapController
//        locationController.delegate = self

        topStackView.axis = axisForSize(view.bounds.size)
    }

    // Alternative to wiring up the interface in viewDidLoad (above) is to
    // use prepare(for segue:sender:) which is still called for 
    // embed segues.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let locationController = destination as? LocationTableViewController {
            locationTableViewController = locationController
            locationController.delegate = self
        }

        if let mapController = destination as? MapViewController {
            mapViewController = mapController
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        topStackView.axis = axisForSize(size)
    }

    private func axisForSize(_ size: CGSize) -> UILayoutConstraintAxis {
        return size.width > size.height ? .horizontal : .vertical
    }
}

extension MasterViewController: LocationProviderDelegate {

    func didSelectLocation(_ location: Location) {
        mapViewController?.coordinate = location.coordinate
    }
}
