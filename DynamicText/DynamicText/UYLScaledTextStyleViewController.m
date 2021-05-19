//
//  UYLScaledTextStyleViewController.m
//  DynamicText
//
//  Created by Keith Harrison on 18/12/2013.
//  Copyright (c) 2013 Keith Harrison. All rights reserved.
//

#import "UYLScaledTextStyleViewController.h"
#import "UIFont+UYLScaledFont.h"

@interface UYLScaledTextStyleViewController ()
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

@implementation UYLScaledTextStyleViewController

#pragma mark -
#pragma mark === View Life Cycle ===
#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    [[NSNotificationCenter defaultCenter] addObserver:self
      selector:@selector(updateTextStyles:)
      name:UIContentSizeCategoryDidChangeNotification
      object:nil];
}

- (void)configureView {
    CGFloat scaleFactor = 2.0;
    
    self.title1Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle1 scale:scaleFactor];
    self.title2Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle2 scale:scaleFactor];
    self.title3Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleTitle3 scale:scaleFactor];
    self.headlineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline scale:scaleFactor];
    self.subheadLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline scale:scaleFactor];
    self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody scale:scaleFactor];
    self.calloutLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCallout scale:scaleFactor];
    self.footnoteLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote scale:scaleFactor];
    self.caption1Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1 scale:scaleFactor];
    self.caption2Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2 scale:scaleFactor];
}

#pragma mark -
#pragma mark === Notification Methods ===
#pragma mark -

- (void)updateTextStyles:(NSNotification *)notification {
    [self configureView];
}
@end
