//
//  UYLScaledTextStyleViewController.m
//  DynamicText
//
//  Created by Keith Harrison on 18/12/2013.
//  Copyright (c) 2013 Keith Harrison. All rights reserved.
//

#import "UYLScaledTextStyleViewController.h"
#import "UYLFont.h"

@implementation UYLScaledTextStyleViewController

#pragma mark -
#pragma mark === View Life Cycle ===
#pragma mark -

- (void)configureView
{
    CGFloat scaleFactor = 2.0;
    self.textSizeLabel.text = [[UIApplication sharedApplication] preferredContentSizeCategory];
    self.headlineLabel.font = [UYLFont preferredFontForTextStyle:UIFontTextStyleHeadline scale:scaleFactor];
    self.subheadLabel.font = [UYLFont preferredFontForTextStyle:UIFontTextStyleSubheadline scale:scaleFactor];
    self.bodyLabel.font = [UYLFont preferredFontForTextStyle:UIFontTextStyleBody scale:scaleFactor];
    self.caption1Label.font = [UYLFont preferredFontForTextStyle:UIFontTextStyleCaption1 scale:scaleFactor];
    self.caption2Label.font = [UYLFont preferredFontForTextStyle:UIFontTextStyleCaption2 scale:scaleFactor];
    self.footnoteLabel.font = [UYLFont preferredFontForTextStyle:UIFontTextStyleFootnote scale:scaleFactor];
}

@end
