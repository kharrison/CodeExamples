//
//  UYLFont.h
//  DynamicText
//
//  Created by Keith Harrison on 18/12/2013.
//  Copyright (c) 2013 Keith Harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UYLFont : NSObject

// +preferredFontForTextStyle:scale:
//
// Return a UIFont object for the specified text style that is scaled by the
// speficied scale factor.
//
// The text style is a UIFontDescriptor Text Style
//
// The scaleFactor modifies the default point size of the text style. So for
// a font that is twice the default size specify a scaleFactor of 2.0.

+ (UIFont *)preferredFontForTextStyle:(NSString *)style scale:(CGFloat)scaleFactor;

@end
