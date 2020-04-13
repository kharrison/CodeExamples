#  Scaled Font

## Using Dynamic Type With Custom Fonts

An example of using custom fonts with dynamic type making use of the `UIFontMetrics` class introduced with iOS 11. It provides examples using the Noteworthy font which is built-in to iOS and the Noto Serif font which was downloaded from google fonts:

+ [Noto Serif](https://fonts.google.com/specimen/Noto+Serif?selection.family=Noto+Serif)

*Refer to LICENSE.txt if you plan on using Noto Serif in a shipping application.*

**This project requires iOS 11**

### ScaledFont

A utility class to help you use custom fonts with dynamic type.

To use this class you must supply the name of a style dictionary for the font when creating the class. The style dictionary should be stored as a property list file in the main bundle.

The style dictionary contains an entry for each text style that uses the raw string value for each `UIFontTextStyle` as the key.

The value of each entry is a dictionary with two keys:

+ fontName: A String which is the font name.
+ fontSize: A number which is the point size to use at the `.large` content size.

For example to use a 17 pt Noteworthy-Bold font for the `.headline` style at the `.large` content size:

    <dict>
        <key>UICTFontTextStyleHeadline</key>
        <dict>
            <key>fontName</key>
            <string>Noteworthy-Bold</string>
            <key>fontSize</key>
            <integer>17</integer>
        </dict>
    </dict>

You do not need to include an entry for every text style but if you try to use a text style that is not included in the dictionary it will fallback to the system preferred font.

### Further Details

See the following blog post for further details:

+ [Using A Custom Font With Dynamic Type](https://useyourloaf.com/blog/using-a-custom-font-with-dynamic-type/)
