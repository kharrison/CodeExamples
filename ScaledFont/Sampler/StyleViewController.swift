//  Copyright © 2021 Keith Harrison. All rights reserved.
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

import ScaledFont
import UIKit

final class StyleViewController: UIViewController {
//    private let fontName = "Default"
//    private let fontName = "Noteworthy"
    private let fontName = "NotoSerif"

    private let defaultSpacing: CGFloat = 8.0

    private lazy var scaledFont: ScaledFont = {
        ScaledFont(fontName: fontName)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = fontName
        setupViews()
    }

    private lazy var title1Label: UILabel = {
        label(forTextStyle: .title1, text: "Title 1")
    }()

    private lazy var title2Label: UILabel = {
        label(forTextStyle: .title2, text: "Title 2")
    }()

    private lazy var title3Label: UILabel = {
        label(forTextStyle: .title3, text: "Title 3")
    }()

    private lazy var headlineLabel: UILabel = {
        label(forTextStyle: .headline, text: "Headline")
    }()

    private lazy var subheadlineLabel: UILabel = {
        label(forTextStyle: .subheadline, text: "Subheadline")
    }()

    private lazy var bodyLabel: UILabel = {
        label(forTextStyle: .body, text: "Body")
    }()

    private lazy var calloutLabel: UILabel = {
        label(forTextStyle: .callout, text: "Callout")
    }()

    private lazy var footnoteLabel: UILabel = {
        label(forTextStyle: .footnote, text: "Footnote")
    }()

    private lazy var caption1Label: UILabel = {
        label(forTextStyle: .caption1, text: "Caption 1")
    }()

    private lazy var caption2Label: UILabel = {
        label(forTextStyle: .caption2, text: "Caption 2")
    }()

    private func label(forTextStyle textStyle: UIFont.TextStyle, text: String) -> UILabel {
        let label = UILabel()
        label.font = scaledFont.font(forTextStyle: textStyle)
        label.adjustsFontForContentSizeCategory = true
        label.text = text
        label.numberOfLines = 0
        return label
    }

    private func setupViews() {
        let stackView = UIStackView(arrangedSubviews: [title1Label, title2Label, title3Label, headlineLabel, subheadlineLabel, bodyLabel, calloutLabel, footnoteLabel, caption1Label, caption2Label])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = defaultSpacing
        stackView.axis = .vertical

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)

        let margins = view.readableContentGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            scrollView.topAnchor.constraint(equalTo: stackView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),

            scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
}
