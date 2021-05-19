# DynamicText

## Responding to text size changes

This is a example project showing how to respond to the user changing
the preferred text size.

**Minimum deployment target is now iOS 9.0 using Xcode 12**

The `UYLTextStyleViewController` shows the standard way to listen for
and respond to changes to the users preferred text size using the
built-in `UIFont` Text Styles.

For further details see the following blog post:

+ [Supporting Dynamic Type](https://useyourloaf.com/blog/supporting-dynamic-type/)

The `UYLScaledTextStyleViewController` extends the basic approach by
showing how to scale the preferred fonts using a `UIFontDescriptor`.
A convenience method to return the scaled font is added as a
category of `UIFont` for this purpose.

For further details see the following blog post:

+ [Scaling Dynamic Type With Font Descriptors](https://useyourloaf.com/blog/scaling-dynamic-type-with-font-descriptors/)

## History

Version 1.4   19 May 2021 Updated for Xcode 12 and Swift
Version 1.3   11 January 2020 Updated for Xcode 11  
Version 1.2   14 August 2017    Updated for Xcode 8 and iOS 10  
Version 1.1   30 December 2013  Added UYLScaledTextViewController  
Version 1.0   06 October 2013   Initial version.  
