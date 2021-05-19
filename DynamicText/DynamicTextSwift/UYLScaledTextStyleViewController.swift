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

import UIKit

final class UYLScaledTextStyleViewController: UIViewController {
    @IBOutlet private var allLabels: [UILabel]!
    @IBOutlet private var title1Label: UILabel!
    @IBOutlet private var title2Label: UILabel!
    @IBOutlet private var title3Label: UILabel!
    @IBOutlet private var headlineLabel: UILabel!
    @IBOutlet private var subheadLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    @IBOutlet private var calloutLabel: UILabel!
    @IBOutlet private var footnoteLabel: UILabel!
    @IBOutlet private var caption1Label: UILabel!
    @IBOutlet private var caption2Label: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextStyles(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }
    
    @objc private func updateTextStyles(_ notification: Notification) {
        configureView()
    }
    
    private func configureView() {
        let scaleFactor: CGFloat = 2.0
        
        title1Label.font = UIFont.preferredFont(forTextStyle: .title1, scaleFactor: scaleFactor)
        title2Label.font = UIFont.preferredFont(forTextStyle: .title2, scaleFactor: scaleFactor)
        title3Label.font = UIFont.preferredFont(forTextStyle: .title3, scaleFactor: scaleFactor)
        headlineLabel.font = UIFont.preferredFont(forTextStyle: .headline, scaleFactor: scaleFactor)
        subheadLabel.font = UIFont.preferredFont(forTextStyle: .subheadline, scaleFactor: scaleFactor)
        bodyLabel.font = UIFont.preferredFont(forTextStyle: .body, scaleFactor: scaleFactor)
        calloutLabel.font = UIFont.preferredFont(forTextStyle: .callout, scaleFactor: scaleFactor)
        footnoteLabel.font = UIFont.preferredFont(forTextStyle: .footnote, scaleFactor: scaleFactor)
        caption1Label.font = UIFont.preferredFont(forTextStyle: .caption1, scaleFactor: scaleFactor)
        caption2Label.font = UIFont.preferredFont(forTextStyle: .caption2, scaleFactor: scaleFactor)
    }
}
