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
import SwiftUI

struct StyleView: View {
    let fontName: String

    var body: some View {
        NavigationView {
            ScrollView {
                TextStyles()
            }
            .navigationBarTitle(fontName, displayMode: .inline)
        }
    }
}

private struct TextStyles: View {
    var defaultSpacing: CGFloat = 8.0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: defaultSpacing) {
                Text("Title 1")
                    .scaledFont(.title)

                if #available(iOS 14.0, *) {
                    Text("Title 2")
                        .scaledFont(.title2)
                }

                if #available(iOS 14.0, *) {
                    Text("Title 3")
                        .scaledFont(.title3)
                }

                Text("Headline")
                    .scaledFont(.headline)

                Text("Subheadline")
                    .scaledFont(.subheadline)

                Text("Body")
                    .scaledFont(.body)

                Text("Callout")
                    .scaledFont(.callout)

                Text("Footnote")
                    .scaledFont(.footnote)

                Text("Caption 1")
                    .scaledFont(.caption)

                if #available(iOS 14.0, *) {
                    Text("Caption 2")
                        .scaledFont(.caption2)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let fontName = "Noteworthy"

    static var previews: some View {
        StyleView(fontName: fontName)
            .environment(\.scaledFont, ScaledFont(fontName: fontName))
    }
}
