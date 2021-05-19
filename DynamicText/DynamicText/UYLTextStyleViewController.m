//  Copyright © 2013-2021 Keith Harrison. All rights reserved.
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

#import "UYLTextStyleViewController.h"

@interface UYLTextStyleViewController ()
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *allLabels;

@property (weak, nonatomic) IBOutlet UILabel *title1Label;
@property (weak, nonatomic) IBOutlet UILabel *title2Label;
@property (weak, nonatomic) IBOutlet UILabel *title3Label;
@property (weak, nonatomic) IBOutlet UILabel *headlineLabel;
@property (weak, nonatomic) IBOutlet UILabel *subheadLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *calloutLabel;
@property (weak, nonatomic) IBOutlet UILabel *footnoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *caption1Label;
@property (weak, nonatomic) IBOutlet UILabel *caption2Label;
@end

@implementation UYLTextStyleViewController

#pragma mark -
#pragma mark === View Life Cycle ===
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 10, *)) {
        for (UILabel *label in self.allLabels) {
            label.adjustsFontForContentSizeCategory = YES;
        }
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self
        selector:@selector(updateTextStyles:)
        name:UIContentSizeCategoryDidChangeNotification
        object:nil];
    }
}

#pragma mark -
#pragma mark === Notification Methods ===
#pragma mark -

- (void)updateTextStyles:(NSNotification *)notification {
    self.title1Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1];
    self.title2Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle2];
    self.title3Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle3];
    self.headlineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.subheadLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.calloutLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCallout];
    self.footnoteLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    self.caption1Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.caption2Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
}

@end
