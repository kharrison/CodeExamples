//
//  LevelView.h
//  Designable
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2015-2017 Keith Harrison. All rights reserved.
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


@import UIKit;

IB_DESIGNABLE
/**
 A custom level view displayed as a horizontal colored bar which
 changes color as the level drops below a configurable theshold.
 Set the value of the level as a CGFloat between 0.0 and 1.0.
 Customise the colors of the bar, the threshold, border width
 and border color as required.
 */
@interface LevelView : UIView
/**
 The current level value in the range 0.0 - 1.0. Defaults to 1.0.
 */
@property (nonatomic, assign) IBInspectable CGFloat value;
/**
 The threshold value in the range 0.0 - 1.0 at which the bar color
 changes between emptyColor and fullColor. Default is 0.3.
 */
@property (nonatomic, assign) IBInspectable CGFloat threshold;
/**
 The border width for the frame surrounding the bar. Default is 2.0.
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/**
 The color of the bar border. Default is black.
 */
@property (nonatomic, copy)   IBInspectable UIColor *borderColor;
/**
 The color of the bar when value >= threshold. Default is green.
 */
@property (nonatomic, copy)   IBInspectable UIColor *fullColor;
/**
 The color of the bar when value < threshold. Default is red.
 */
@property (nonatomic, copy)   IBInspectable UIColor *emptyColor;
@end
