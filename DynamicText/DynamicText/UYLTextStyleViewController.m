//
//  UYLTableViewController.m
//  DynamicText
//
// Created by Keith Harrison http://useyourloaf.com
// Copyright (c) 2013 Keith Harrison. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//
// Redistributions in binary form must reproduce the above copyright
// notice, this list of conditions and the following disclaimer in the
// documentation and/or other materials provided with the distribution.
//
// Neither the name of Keith Harrison nor the names of its contributors
// may be used to endorse or promote products derived from this software
// without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
// DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


#import "UYLTextStyleViewController.h"

@implementation UYLTextStyleViewController

#pragma mark -
#pragma mark === View Life Cycle ===
#pragma mark -

- (void)viewDidLoad
{
	[super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self configureView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configureView
{
    self.textSizeLabel.text = [[UIApplication sharedApplication] preferredContentSizeCategory];
    self.headlineLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.subheadLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    self.bodyLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.caption1Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.caption2Label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    self.footnoteLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
}

#pragma mark -
#pragma mark === Notification Methods ===
#pragma mark -

- (void)didChangePreferredContentSize:(NSNotification *)notification
{
    [self configureView];
}

@end
