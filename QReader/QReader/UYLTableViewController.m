//
//  UYLTableViewController.m
//  QReader
//
// Created by Keith Harrison http://useyourloaf.com
// Copyright (c) 2014 Keith Harrison. All rights reserved.
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


#import <AVFoundation/AVFoundation.h>
#import "UYLTableViewController.h"
#import "UYLWebViewController.h"
#import "UYLTextCell.h"

@interface UYLTableViewController ()

@property (nonatomic, strong) UYLTextCell *prototypeCell;

@end

@implementation UYLTableViewController

static NSString *UYLTextCellIdentifier = @"UYLTextCell";
static NSString *UYLSegueToWebView = @"UYLSegueToWebView";

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -

- (UYLTextCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:UYLTextCellIdentifier];
    }
    return _prototypeCell;
}

#pragma mark -
#pragma mark === View Lifecycle ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)didChangePreferredContentSize:(NSNotification *)notification
{
    [self.tableView reloadData];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark === UITableViewDataSource ===
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.codeObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UYLTextCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark -
#pragma mark === UITableViewDelegate ===
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self configureCell:self.prototypeCell forRowAtIndexPath:indexPath];
    self.prototypeCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.tableView.bounds), CGRectGetHeight(self.prototypeCell.bounds));
    [self.prototypeCell layoutIfNeeded];
    
    CGSize size = [self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

#pragma mark -
#pragma mark === Segue ===
#pragma mark -

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    BOOL gotLink = NO;
    
    if ([identifier isEqualToString:UYLSegueToWebView])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AVMetadataObject *object = [self.codeObjects objectAtIndex:indexPath.row];
        if ([object.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            gotLink = [self codeObjectContainsLink:(AVMetadataMachineReadableCodeObject *)object];
        }
    }
    
    return gotLink;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:UYLSegueToWebView])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        AVMetadataMachineReadableCodeObject *codeObject = [self.codeObjects objectAtIndex:indexPath.row];

        UYLWebViewController *viewController = segue.destinationViewController;
        viewController.url = [self firstLinkInCodeObject:codeObject];
    }
}

#pragma mark -
#pragma mark === Utility methods ===
#pragma mark -

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[UYLTextCell class]])
    {
        UYLTextCell *textCell = (UYLTextCell *)cell;
        AVMetadataObject *object = [self.codeObjects objectAtIndex:indexPath.row];
        
        textCell.valueLabel.text = @"No value";
        textCell.typeLabel.text = object.type;
        textCell.accessoryType = UITableViewCellAccessoryNone;
        textCell.valueLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        textCell.typeLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        
        if ([object.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            AVMetadataMachineReadableCodeObject *codeObject = (AVMetadataMachineReadableCodeObject *)object;
            NSString *stringValue = codeObject.stringValue ? codeObject.stringValue : @"Unable to decode";
            textCell.valueLabel.text = stringValue;
            
            if ([self codeObjectContainsLink:codeObject])
            {
                textCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
    }
}

- (BOOL)codeObjectContainsLink:(AVMetadataMachineReadableCodeObject *)codeObject
{
    NSString *stringValue = codeObject.stringValue;
    
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    NSUInteger matchCount = [detector numberOfMatchesInString:stringValue options:0 range:NSMakeRange(0, stringValue.length)];
    return (matchCount > 0) ? YES : NO;
}

- (NSURL *)firstLinkInCodeObject:(AVMetadataMachineReadableCodeObject *)codeObject
{
    NSURL *url = nil;
    NSString *stringValue = codeObject.stringValue;
    
    NSError *error = nil;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    NSTextCheckingResult *result = [detector firstMatchInString:stringValue options:0 range:NSMakeRange(0, stringValue.length)];
    if (result.resultType == NSTextCheckingTypeLink)
    {
        url = result.URL;
    }
    
    return url;
}

@end
