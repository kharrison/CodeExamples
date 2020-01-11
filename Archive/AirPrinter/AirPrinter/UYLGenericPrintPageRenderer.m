//
//  UYLGenericPrintPageRenderer.m
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

#import "UYLGenericPrintPageRenderer.h"

@implementation UYLGenericPrintPageRenderer

@synthesize headerText=_headerText;
@synthesize footerText=_footerText;

#pragma mark -
#pragma mark === Initialization and cleanup ===
#pragma mark -

- (void)dealloc {
    [_headerText release];
    [_footerText release];
    [super dealloc];
}

#pragma mark -
#pragma mark === Accessor Methods ===
#pragma mark -

- (void)setHeaderText:(NSString *)newString {
    
    if (_headerText != newString) {
        [_headerText release];
        _headerText = [newString copy];
        
        if (_headerText) {
            UIFont *font = [UIFont fontWithName:@"Helvetica" size:HEADER_FONT_SIZE]; 
            CGSize size = [_headerText sizeWithFont:font];
            self.headerHeight = size.height + HEADER_TOP_PADDING + HEADER_BOTTOM_PADDING;
        }
    }
}

- (void)setFooterText:(NSString *)newString {
    
    if (_footerText != newString) {
        [_footerText release];
        _footerText = [newString copy];
        
        if (_footerText) {
            UIFont *font = [UIFont fontWithName:@"Helvetica" size:FOOTER_FONT_SIZE]; 
            CGSize size = [_footerText sizeWithFont:font];
            self.footerHeight = size.height + FOOTER_TOP_PADDING + FOOTER_BOTTOM_PADDING;
        }
    }
}

#pragma mark -
#pragma mark === UIPrintPageRendered Methods ===
#pragma mark -

- (void)drawHeaderForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)headerRect {

    if (self.headerText) {
        UIFont *font = [UIFont fontWithName:@"Helvetica" size:HEADER_FONT_SIZE];
        CGSize size = [self.headerText sizeWithFont:font];

        // Center Text
        CGFloat drawX = CGRectGetMaxX(headerRect)/2 - size.width/2;
        CGFloat drawY = CGRectGetMaxY(headerRect) - size.height - HEADER_BOTTOM_PADDING;
        CGPoint drawPoint = CGPointMake(drawX, drawY);
        [self.headerText drawAtPoint:drawPoint withFont:font];
    }
}

- (void)drawFooterForPageAtIndex:(NSInteger)pageIndex inRect:(CGRect)footerRect {
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:FOOTER_FONT_SIZE];

    NSString *pageNumber = [NSString stringWithFormat:@"- %d -", pageIndex+1];
    CGSize size = [pageNumber sizeWithFont:font];
    CGFloat drawX = CGRectGetMaxX(footerRect)/2 - size.width/2;
    CGFloat drawY = CGRectGetMaxY(footerRect) - size.height - FOOTER_BOTTOM_PADDING;
    CGPoint drawPoint = CGPointMake(drawX, drawY);
    [pageNumber drawAtPoint:drawPoint withFont:font];

    if (self.footerText) {
        size = [self.footerText sizeWithFont:font];
        drawX = CGRectGetMaxX(footerRect) - size.width - FOOTER_RIGHT_PADDING;
        drawPoint = CGPointMake(drawX, drawY);
        [self.footerText drawAtPoint:drawPoint withFont:font];
    }
}

@end
