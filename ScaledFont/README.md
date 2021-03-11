#  Scaled Font

## Using Dynamic Type With Custom Fonts

An example of using custom fonts with dynamic type making use of the `UIFontMetrics` class introduced with iOS 11. It provides examples using the Noteworthy font that Apple ships built-in to iOS and the Noto Serif font which you can download from google fonts:

+ [Noto Serif](https://fonts.google.com/specimen/Noto+Serif?selection.family=Noto+Serif)

*See the LICENSE.txt file if you plan on using Noto Serif in a shipping application.*

## Sample Targets

There are two targets in this project:

+ Sampler - A UIKit example that requires a minimum of iOS 11
+ SamplerUI - A SwiftUI example that requires a minimum of iOS 14

## Swift Package

The ScaledFont implementation is now provided as a Swift Package Manager dependency. You can find the GitHub repository for the package here:

+ [ScaledFont on GitHub](https://github.com/kharrison/ScaledFont)

## ScaledFont Details

The `ScaledFont` type is a utility type to help you use custom fonts with dynamic type. You must give the name of a style dictionary for the font when creating the `ScaledFont`. You include the style dictionary as a property list file in the main bundle of your app.

The style dictionary contains an entry for each text style. The available text styles are:

+ `largeTitle`, `title`, `title2`, `title3`
+  `headline`, `subheadline`, `body`, `callout`
+  `footnote`, `caption`, `caption2`

The value of each entry is a dictionary with two keys:

+ `fontName`: A `String` which is the font name.
+ `fontSize`: A number which is the point size to use at the `.large` (base) content size.

For example to use a 17 pt Noteworthy-Bold font for the `.headline` style at the `.large` content size:

```
<dict>
  <key>headline</key>
  <dict>
    <key>fontName</key>
    <string>Noteworthy-Bold</string>
    <key>fontSize</key>
    <integer>17</integer>
  </dict>
</dict>
```

You do not need to include an entry for every text style but if you try to use a text style that is not included in the dictionary it will fallback to the system preferred font.

## Using With UIKit

For `UIKit`, apply the scaled font to text labels, text fields or text views:

 ```swift
let scaledFont = ScaledFont(fontName: "Noteworthy")
label.font = scaledFont.font(forTextStyle: .headline)
label.adjustsFontForContentSizeCategory = true
```

Remember to set the `adjustsFontFotContentSizeCategory` property to have the font size adjust automatically when the user changes their preferred content size.

## Using With SwiftUI

For `SwiftUI`, add the scaled font to the environment of a view:

 ```swift
ContentView()
.environment(\.scaledFont, scaledFont)
```

Then apply the scaled fint view modifier to any view containing text in the view hierarchy:

 ```swift
Text("Headline")
.scaledFont(.headline)
```
## Further Details

See this blog post for further details:

+ [Using A Custom Font With Dynamic Type](https://useyourloaf.com/blog/using-a-custom-font-with-dynamic-type/)
