//  Copyright © 2018 Keith Harrison. All rights reserved.
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

final class ForecastViewController: UIViewController {

    private enum ViewMetrics {
        static let margin: CGFloat = 20.0
        static let backgroundColor = UIColor(named: "SkyBlue")
    }

    private let forecastView: ForecastView = {
        let view = ForecastView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ViewMetrics.backgroundColor
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(forecastView)
        return scrollView
    }()

    private let infoButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showInfo(_:)), for: .touchUpInside)
        return button
    }()

    var forecast: Forecast? { didSet { updateView() } }

    private func updateView() {
        if let forecast = forecast {
            forecastView.titleLabel.text = forecast.title
            forecastView.summaryLabel.text = forecast.summary
            forecastView.imageView.image = forecast.icon()
            forecastView.imageView.sizeToFit()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateView()
    }

    private func setupView() {
        view.backgroundColor = ViewMetrics.backgroundColor
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: ViewMetrics.margin, leading: ViewMetrics.margin, bottom: ViewMetrics.margin, trailing: ViewMetrics.margin)
        view.addSubview(scrollView)

        scrollView.addSubview(infoButton)

        let margin = view.readableContentGuide
        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide

        // Classic scroll view setup using scroll view anchors
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            scrollView.leadingAnchor.constraint(equalTo: forecastView.leadingAnchor),
//            scrollView.topAnchor.constraint(equalTo: forecastView.topAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: forecastView.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: forecastView.bottomAnchor),
//
//            forecastView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
//        ])

        // Scroll view layout guides (iOS 11)
        NSLayoutConstraint.activate([
            frameGuide.leadingAnchor.constraint(equalTo: margin.leadingAnchor),
            frameGuide.topAnchor.constraint(equalTo: view.topAnchor),
            frameGuide.trailingAnchor.constraint(equalTo: margin.trailingAnchor),
            frameGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentGuide.leadingAnchor.constraint(equalTo: forecastView.leadingAnchor),
            contentGuide.topAnchor.constraint(equalTo: forecastView.topAnchor),
            contentGuide.trailingAnchor.constraint(equalTo: forecastView.trailingAnchor),
            contentGuide.bottomAnchor.constraint(equalTo: forecastView.bottomAnchor),

            contentGuide.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),

            infoButton.leadingAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.leadingAnchor),
            infoButton.topAnchor.constraint(equalTo: scrollView.layoutMarginsGuide.topAnchor)
            ])
    }
}

extension ForecastViewController {
    @objc private func showInfo(_ sender: UIButton) {
        print("Show Info")
    }
}
