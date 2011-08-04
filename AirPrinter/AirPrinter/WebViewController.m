//
//  WebViewController.m
//  AirPrinter
//
//  Created by Keith Harrison on 31 July 2011 http://useyourloaf.com
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

#import "WebViewController.h"
#import "UYLGenericPrintPageRenderer.h"

@implementation WebViewController

@synthesize query=_query;
@synthesize webView=_webView;
@synthesize printButton=_printButton;

#pragma mark -
#pragma mark === View Setup ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.query;
    
	NSString *escapedQuery = [self.query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [[NSURL alloc] initWithString:escapedQuery];
	
    if (url) {

        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url]; 
        [self.webView loadRequest:request]; 

        [request release];
        [url release];
    }
    
    if ([UIPrintInteractionController isPrintingAvailable]) {
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                                   target:self 
                                                                                   action:@selector(printWebView:)];
        
        [self.navigationItem setRightBarButtonItem:barButton animated:NO];
        self.printButton = barButton;
        [barButton release];
    }
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    self.query = nil;
    self.printButton = nil;
    
    self.webView.delegate = nil;
    self.webView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    self.webView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.webView stopLoading];
    self.webView.delegate = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        if ([UIPrintInteractionController isPrintingAvailable]) {
            UIPrintInteractionController *pc = [UIPrintInteractionController sharedPrintController];
            [pc dismissAnimated:animated];
        }
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    self.webView.delegate = nil;
    [_webView release];
    
    [_printButton release];
    [_query release];
    [super dealloc];
}

#pragma mark -
#pragma mark === Web View Delegate Methods ===
#pragma mark -

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='blue'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [self.webView loadHTMLString:errorString baseURL:nil];
}

#pragma mark -
#pragma mark === Printing ===
#pragma mark -

// Basic Printing
//- (void)printWebView:(id)sender {
//      
//    UIPrintInteractionController *pc = [UIPrintInteractionController sharedPrintController];
//    
//    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
//    printInfo.outputType = UIPrintInfoOutputGeneral;
//    printInfo.jobName = self.query;
//    pc.printInfo = printInfo;
//    
//    pc.showsPageRange = YES;   
//    
//    UIViewPrintFormatter *formatter = [self.webView viewPrintFormatter];
//    pc.printFormatter = formatter;
//    
//    UIPrintInteractionCompletionHandler completionHandler = 
//    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
//        if(!completed && error){
//            DLog(@"Print failed - domain: %@ error code %u", error.domain, error.code);	
//        }
//    };
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        [pc presentFromBarButtonItem:self.printButton animated:YES completionHandler:completionHandler];
//    } else {
//        [pc presentAnimated:YES completionHandler:completionHandler];
//    }
//}

// Printing using a Print Page Renderer
- (void)printWebView:(id)sender {
    
    UIPrintInteractionController *pc = [UIPrintInteractionController sharedPrintController];
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = self.query;
    pc.printInfo = printInfo;
    pc.showsPageRange = YES;
    
    UYLGenericPrintPageRenderer *renderer = [[UYLGenericPrintPageRenderer alloc] init];
    renderer.headerText = printInfo.jobName;
    renderer.footerText = @"AirPrinter - UseYourLoaf.com";
    
    UIViewPrintFormatter *formatter = [self.webView viewPrintFormatter];
    [renderer addPrintFormatter:formatter startingAtPageAtIndex:0];
    pc.printPageRenderer = renderer;
    [renderer release];
    
    UIPrintInteractionCompletionHandler completionHandler = 
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(!completed && error){
            DLog(@"Print failed - domain: %@ error code %u", error.domain, error.code);	
        }
    };
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [pc presentFromBarButtonItem:self.printButton animated:YES completionHandler:completionHandler];
    } else {
        [pc presentAnimated:YES completionHandler:completionHandler];
    }
}

@end
