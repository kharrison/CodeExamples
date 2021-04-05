//  Created by Keith Harrison https://useyourloaf.com
//  Copyright (c) 2017-2020 Keith Harrison. All rights reserved.
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
import WebKit

final class WebViewController: UIViewController {
    @IBOutlet private var backwardButton: UIBarButtonItem!
    @IBOutlet private var forwardButton: UIBarButtonItem!

    var html: String = "default" {
        didSet {
            loadHTML(html)
        }
    }

    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()

        if #available(iOS 14.0, *) {
            // Allow restricted API access on the
            // app-bound domains (cookies, etc).
            // Doesn't seem to be required
            // configuration.limitsNavigationsToAppBoundDomains = true
        } else {
            // Fallback to WKPreferences for iOS 13 to
            // disable javascript.
            let preferences = WKPreferences()
            // preferences.javaScriptEnabled = false
            configuration.preferences = preferences
        }

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        return webView
    }()

    override func loadView() {
        view = webView
        loadHTML(html)
        NotificationCenter.default.addObserver(self, selector: #selector(contentSizeDidChange(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
    }

    @IBAction func forwardAction(_ sender: UIBarButtonItem) {
        webView.goForward()
    }

    @IBAction func backwardAction(_ sender: UIBarButtonItem) {
        webView.goBack()
    }

    @objc private func contentSizeDidChange(_ notification: Notification) {
        webView.reload()
    }

    private func loadHTML(_ name: String) {
        if let url = Bundle.main.url(forResource: name, withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        if #available(iOS 14.0, *) {
            // To disable all javascript content
            // preferences.allowsContentJavaScript = true
        }
        decisionHandler(.allow, preferences)
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
        updateNavigationState(webView)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        updateNavigationState(webView)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateNavigationState(webView)
    }

    private func updateNavigationState(_ webView: WKWebView) {
        backwardButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}
