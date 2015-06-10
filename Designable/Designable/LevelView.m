//
//  LevelView.m
//  Designable
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2015 Keith Harrison. All rights reserved.
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


#import "LevelView.h"

@interface LevelView ()
@property (nonatomic, strong) CAShapeLayer *barLayer;
@end

@implementation LevelView

- (void)setupDefaults {
    if (self.barLayer == nil) {
        self.barLayer = [CAShapeLayer layer];
        [self.layer addSublayer:self.barLayer];
    }
    self.value = 1.0f;
    self.threshold = 0.3f;
    self.borderWidth = 2.0f;
    self.borderColor = [UIColor blackColor];
    self.fullColor = [UIColor greenColor];
    self.emptyColor = [UIColor redColor];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateLayerProperties];
}

- (void)setValue:(CGFloat)value {
    if ((value >= 0.0) && (value <= 1.0)) {
        _value = value;
        [self updateLayerProperties];
    }
}

- (void)setThreshold:(CGFloat)threshold {
    if ((threshold >= 0.0) && (threshold <= 1.0)) {
        _threshold = threshold;
        [self updateLayerProperties];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (borderWidth != _borderWidth) {
        _borderWidth = borderWidth;
        [self updateLayerProperties];
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    if (borderColor != _borderColor) {
        _borderColor = borderColor;
        [self updateLayerProperties];
    }
}

- (void)setFullColor:(UIColor *)fullColor {
    if (fullColor != _fullColor) {
        _fullColor = fullColor;
        [self updateLayerProperties];
    }
}

- (void)setEmptyColor:(UIColor *)emptyColor {
    if (emptyColor != _emptyColor) {
        _emptyColor = emptyColor;
        [self updateLayerProperties];
    }
}

- (void)updateLayerProperties {
    CGRect barRect = self.bounds;
    barRect.size.width = self.bounds.size.width * self.value;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:barRect];
    self.barLayer.path = path.CGPath;
    self.barLayer.fillColor = (self.value >= self.threshold) ? self.fullColor.CGColor : self.emptyColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
}

@end
