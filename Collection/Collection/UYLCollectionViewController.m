//
//  UYLViewController.m
//  Collection
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


#import "UYLCollectionViewController.h"
#import "UYLViewController.h"
#import "UYLSimpleCell.h"

@interface UYLCollectionViewController () <UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *uylPopoverController;

@end

@implementation UYLCollectionViewController

static NSString *UYLStoryboardViewControllerID = @"UYLViewController";
static NSString *UYLSimpleCellID = @"UYLSimpleCell";

#pragma mark -
#pragma mark === UICollectionViewDataSource ===
#pragma mark -

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UYLSimpleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UYLSimpleCellID forIndexPath:indexPath];
    cell.cellLabel.text = [NSString stringWithFormat:@"cell %d",indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark === Gesture Recognizer Action ===
#pragma mark -

- (IBAction)doubleTappedCell:(id)sender
{
    CGPoint tappedPoint = [sender locationInView:self.collectionView];
    NSIndexPath *tappedCellPath = [self.collectionView indexPathForItemAtPoint:tappedPoint];
    
    if (tappedCellPath)
    {
        UYLSimpleCell *cell = (UYLSimpleCell *)[self.collectionView cellForItemAtIndexPath:tappedCellPath];
        [self.collectionView selectItemAtIndexPath:tappedCellPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        
        if (self.uylPopoverController == nil)
        {
            UYLViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:UYLStoryboardViewControllerID];
            self.uylPopoverController = [[UIPopoverController alloc] initWithContentViewController:viewController];
            self.uylPopoverController.delegate = self;
        }
        
        [self.uylPopoverController presentPopoverFromRect:cell.frame
                                                inView:self.collectionView
                              permittedArrowDirections:UIPopoverArrowDirectionAny
                                              animated:YES];

    }
}

#pragma mark -
#pragma mark === UIPopoverControllerDelegate ===
#pragma mark -

- (void)popoverController:(UIPopoverController *)popoverController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing *)view
{
    if (self.uylPopoverController == popoverController)
    {
        NSArray *selectedItems = self.collectionView.indexPathsForSelectedItems;
        NSIndexPath *itemPath = (NSIndexPath *)[selectedItems lastObject];
        if (itemPath)
        {
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:itemPath];
            if (cell)
            {
                CGRect requiredRect = cell.frame;
                *rect = requiredRect;
            }
        }
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    for (NSIndexPath *indexPath in self.collectionView.indexPathsForSelectedItems)
    {
        [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
}

@end
