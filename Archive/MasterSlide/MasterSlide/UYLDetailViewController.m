//
//  UYLDetailViewController.m
//  masterslide
//
//  Created by Keith Harrison on 11-Nov-2011 http://useyourloaf.com
//  Copyright (c) 2011 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  Neither the name of Keith Harrison nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 

#import "UYLDetailViewController.h"
#import "UYLMasterViewController.h"

@interface UYLDetailViewController ()
- (void)addMasterButton;
- (void)removeMasterButton;
- (void)showMasterView;
- (void)hideMasterView;
- (void)configureView;
- (IBAction)handleTap:(UITapGestureRecognizer *)sender;
- (IBAction)handleSwipeRight:(UISwipeGestureRecognizer *)sender;
- (IBAction)handleSwipeLeft:(UISwipeGestureRecognizer *)sender;
@end

@implementation UYLDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailTitle = _detailTitle;
@synthesize toolbar = _toolbar;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterIsVisible = _masterIsVisible;

#pragma mark -
#pragma mark === View Management ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.masterIsVisible = NO;
   
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        [self addMasterButton];
    }

    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.detailItem = nil;
    self.toolbar = nil;
    self.detailTitle = nil;
    self.detailDescriptionLabel = nil;
}

- (void)dealloc
{
    [_detailTitle release];
    [_detailItem release];
    [_toolbar release];
    [_detailDescriptionLabel release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
    {
        [self hideMasterView];
        [self removeMasterButton];
        
    } else {
        [self addMasterButton];
    }
}

#pragma mark -
#pragma mark === Private methods ===
#pragma mark -

- (void)addMasterButton
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Master" 
                                                                      style:UIBarButtonItemStyleBordered 
                                                                     target:self 
                                                                     action:@selector(showMasterView)];
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
    [barButtonItem release];
}

- (void)removeMasterButton
{
    if ([[self.toolbar items] count] > 0)
    {
        NSMutableArray *items = [[self.toolbar items] mutableCopy];
        [items removeObjectAtIndex:0];
        [self.toolbar setItems:items animated:YES];
        [items release];
    }
}

- (void)showMasterView
{
    if (!self.masterIsVisible)
    {
        self.masterIsVisible = YES;
        NSArray *controllers = self.splitViewController.viewControllers;
        UIViewController *rootViewController = [controllers objectAtIndex:0];
        
        UIView *rootView = rootViewController.view;   
        CGRect rootFrame = rootView.frame;
        rootFrame.origin.x += rootFrame.size.width;
        
        [UIView beginAnimations:@"showView" context:NULL];
        rootView.frame = rootFrame;
        [UIView commitAnimations];
    }
}

- (void)hideMasterView
{
    if (self.masterIsVisible)
    {
        self.masterIsVisible = NO;
        NSArray *controllers = self.splitViewController.viewControllers;
        UIViewController *rootViewController = [controllers objectAtIndex:0];
        
        UIView *rootView = rootViewController.view;
        CGRect rootFrame = rootView.frame;
        rootFrame.origin.x -= rootFrame.size.width;
        
        [UIView beginAnimations:@"hideView" context:NULL];
        rootView.frame = rootFrame;
        [UIView commitAnimations];
    }    
}

- (void)configureView
{
    if (self.detailItem) {
        self.detailTitle.text = [NSString stringWithFormat:@"Item %@", self.detailItem];
        self.detailDescriptionLabel.text = [NSString stringWithFormat:@"You selected item %@", self.detailItem];
    }
}

#pragma mark -
#pragma mark === Gesture Handlers ===
#pragma mark -

- (IBAction)handleSwipeLeft:(UISwipeGestureRecognizer *)sender
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        [self hideMasterView];
    }
}

- (IBAction)handleSwipeRight:(UISwipeGestureRecognizer *)sender
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        [self showMasterView];
    }
}

- (IBAction)handleTap:(UITapGestureRecognizer *)sender
{
    if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation))
    {
        [self hideMasterView];
    }    
}

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -

- (void)setDetailItem:(NSNumber *)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release]; 
        _detailItem = [newDetailItem retain]; 
        [self configureView];
    }
    
    if (self.masterIsVisible) {
        [self hideMasterView];
    }        
}

@end
