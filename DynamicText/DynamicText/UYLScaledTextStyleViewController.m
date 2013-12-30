//
//  UYLScaledTextStyleViewController.m
//  DynamicText
//
//  Created by Keith Harrison on 18/12/2013.
//  Copyright (c) 2013 Keith Harrison. All rights reserved.
//

#import "UYLScaledTextStyleViewController.h"
#import "UIFont+UYLScaledFont.h"

@implementation UYLScaledTextStyleViewController

#pragma mark -
#pragma mark === View Life Cycle ===
#pragma mark -

- (void)configureView
{
    CGFloat scaleFactor = 2.0;
    self.textSizeLabel.text = [[UIApplication sharedApplication] preferredContentSizeCategory];
    self.headlineLabel.font = [UIFont uylPreferredFontForTextStyle:UIFontTextStyleHeadline scale:scaleFactor];
    self.subheadLabel.font = [UIFont uylPreferredFontForTextStyle:UIFontTextStyleSubheadline scale:scaleFactor];
    self.bodyLabel.font = [UIFont uylPreferredFontForTextStyle:UIFontTextStyleBody scale:scaleFactor];
    self.caption1Label.font = [UIFont uylPreferredFontForTextStyle:UIFontTextStyleCaption1 scale:scaleFactor];
    self.caption2Label.font = [UIFont uylPreferredFontForTextStyle:UIFontTextStyleCaption2 scale:scaleFactor];
    self.footnoteLabel.font = [UIFont uylPreferredFontForTextStyle:UIFontTextStyleFootnote scale:scaleFactor];
}

@end
