//  Created by Keith Harrison https://useyourloaf.com
//  Copyright © 2020 Keith Harrison. All rights reserved.
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

import Combine
import UIKit

final class TermsViewController: UIViewController {
    @IBOutlet private var termsSwitch: UISwitch!
    @IBOutlet private var privacySwitch: UISwitch!
    @IBOutlet private var nameField: UITextField!
    @IBOutlet private var submitButton: UIButton!

    @Published private var acceptedTerms: Bool = false
    @Published private var acceptedPrivacy: Bool = false
    @Published private var name: String = ""

    private var stream: AnyCancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        stream = validToSubmit
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: submitButton)
    }

    @IBAction private func acceptTerms(_ sender: UISwitch) {
        acceptedTerms = sender.isOn
    }

    @IBAction private func acceptPrivacy(_ sender: UISwitch) {
        acceptedPrivacy = sender.isOn
    }

    @IBAction private func nameChanged(_ sender: UITextField) {
        name = sender.text ?? ""
    }

    @IBAction private func submitAction(_ sender: UIButton) {
        print("Submit... \(name)")
        print(view.value(forKey: "_autolayoutTrace")!)
    }

    private var validToSubmit: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($acceptedTerms, $acceptedPrivacy, $name)
            .map { terms, privacy, name in
                terms && privacy && !name.isBlank
            }.eraseToAnyPublisher()
    }

    // A longer approach just for fun:
    //
    //    private var validName: AnyPublisher<String?, Never> {
    //        return $name.map { name in
    //            guard !name.isBlank && name.count > 2 else { return nil }
    //            return name
    //        }.eraseToAnyPublisher()
    //    }
    //
    //    private var acceptedAll: AnyPublisher<Bool, Never> {
    //        return Publishers.CombineLatest($acceptedTerms, $acceptedPrivacy)
    //            .map { terms, privacy in
    //                terms && privacy
    //            }.eraseToAnyPublisher()
    //    }
    //
    //    private var validToSubmit: AnyPublisher<Bool, Never> {
    //        return Publishers.CombineLatest(acceptedAll, validName)
    //            .map { terms, name in
    //                terms && name != nil
    //        }.eraseToAnyPublisher()
    //    }
}

#if DEBUG
import SwiftUI

extension TermsViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> TermsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "TermsViewController") as? TermsViewController else {
            fatalError("Cannot load from storyboard")
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: TermsViewController, context: Context) {
    }
}
#endif
