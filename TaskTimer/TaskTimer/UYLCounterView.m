//
//  UYLCounterView.m
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2012 Keith Harrison. All rights reserved.
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


#import "UYLCounterView.h"
#import "NSNumber+UYLTimeFormatter.h"

@interface UYLCounterView ()

@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *stopButton;

- (void)setupView;

@end

@implementation UYLCounterView

@synthesize delegate=_delegate;
@synthesize secondsCounter=_secondsCounter;
@synthesize accessibleElements=_accessibleElements;
@synthesize counterEnabled=_counterEnabled;
@synthesize startButton=_startButton;
@synthesize stopButton=_stopButton;

#define UYLCOUNTERVIEW_LIMIT 3599  // Maximum seconds that can be displayed as mm:ss
#define UYLCOUNTERVIEW_MARGIN 10
#define UYLCOUNTERVIEW_MINFONT 10

#define UYLCOUNTERVIEW_ELEMENTINDEX_STARTBUTTON 0
#define UYLCOUNTERVIEW_ELEMENTINDEX_COUNTERTEXT 1
#define UYLCOUNTERVIEW_ELEMENTINDEX_STOPBUTTON 2

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupView];
    }
    return self;
}

- (void)setSecondsCounter:(NSUInteger)secondsCounter
{
    if (secondsCounter > UYLCOUNTERVIEW_LIMIT)
    {
        secondsCounter = UYLCOUNTERVIEW_LIMIT;
    }
    
    _secondsCounter = secondsCounter;
        
    if (_accessibleElements)
    {
        UIAccessibilityElement *counterElement = [self.accessibleElements objectAtIndex:UYLCOUNTERVIEW_ELEMENTINDEX_COUNTERTEXT];
        counterElement.accessibilityValue = [[NSNumber numberWithInteger:secondsCounter] stringValueAsTime];
    }
    
    [self setNeedsDisplay];
}

- (void)setCounterEnabled:(BOOL)counterEnabled
{
    _counterEnabled = counterEnabled;
    
    if (counterEnabled == YES)
    {
        self.startButton.enabled = YES;
        self.stopButton.enabled = NO;
    }
    else
    {
        self.startButton.enabled = NO;
        self.stopButton.enabled = NO;
    }
}
- (void)drawRect:(CGRect)rect
{
    NSUInteger minutes = self.secondsCounter / 60;
    NSUInteger seconds = self.secondsCounter % 60;
    
    NSString *counterText = [NSString stringWithFormat:@"%02u:%02u", minutes, seconds];
    UIFont *font = [UIFont boldSystemFontOfSize:48];
    
    CGFloat actualFontSize;
    CGSize stringSize = [counterText sizeWithFont:font 
                                      minFontSize:UYLCOUNTERVIEW_MINFONT 
                                   actualFontSize:&actualFontSize 
                                           forWidth:self.bounds.size.width
                                    lineBreakMode:UILineBreakModeTailTruncation];

    
    CGPoint point = CGPointMake((self.bounds.size.width - stringSize.width)/2, 
                                (self.bounds.size.height - stringSize.height)/2);

    [counterText drawAtPoint:point 
                    forWidth:stringSize.width 
                    withFont:font 
                    fontSize:actualFontSize 
               lineBreakMode:UILineBreakModeWordWrap
          baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    
}

#pragma mark -
#pragma mark === Action methods ===
#pragma mark -

- (void)startAction:(UIButton *)sender
{
    self.startButton.enabled = NO;    
    self.stopButton.enabled = YES;
    
    if (_accessibleElements)
    {
        UIAccessibilityElement *startElement = [self.accessibleElements objectAtIndex:UYLCOUNTERVIEW_ELEMENTINDEX_STARTBUTTON];
        startElement.accessibilityTraits = UIAccessibilityTraitButton | UIAccessibilityTraitNotEnabled;
        
        UIAccessibilityElement *stopElement = [self.accessibleElements objectAtIndex:UYLCOUNTERVIEW_ELEMENTINDEX_STOPBUTTON];
        stopElement.accessibilityTraits = UIAccessibilityTraitButton;        
    }
    
    if ([self.delegate respondsToSelector:@selector(didStartCounter)])
    {
        [self.delegate didStartCounter];
    }
}

- (void)stopAction:(UIButton *)sender
{
    self.counterEnabled = NO;

    if (_accessibleElements)
    {
        UIAccessibilityElement *stopElement = [self.accessibleElements objectAtIndex:UYLCOUNTERVIEW_ELEMENTINDEX_STOPBUTTON];
        stopElement.accessibilityTraits = UIAccessibilityTraitButton | UIAccessibilityTraitNotEnabled;
    }

    if ([self.delegate respondsToSelector:@selector(didStopCounter)])
    {
        [self.delegate didStopCounter];
    }
}

#pragma mark -
#pragma mark === Accessibility Container methods ===
#pragma mark -

- (NSArray *)accessibleElements
{
    if (_accessibleElements != nil)
    {
        return _accessibleElements;
    }
    
    _accessibleElements = [[NSMutableArray alloc] init];

    // For the start and stop buttons we need to convert the button frame to the screen
    // coord system when setting the accessibility frame.
    
    // start button
    
    UIAccessibilityElement *startElement = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
    startElement.accessibilityFrame = [self convertRect:self.startButton.frame toView:nil];
    startElement.accessibilityLabel = NSLocalizedString(@"Start", nil);
    startElement.accessibilityTraits = UIAccessibilityTraitButton;
    if (self.startButton.enabled == NO) startElement.accessibilityTraits |= UIAccessibilityTraitNotEnabled;

    [_accessibleElements addObject:startElement];
    
    // The accessibilityFrame is returned in screen coordinates so it is first
    // converted from screen to the local view coord system.
    // The counter element frame is then calculated and then converted back
    // to the screen coordinate system when setting the accessibility frame.

    CGRect frame = [self convertRect:self.accessibilityFrame fromView:nil];

    UIAccessibilityElement *counterElement = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
    CGRect textFrame = CGRectInset(frame, UYLCOUNTERVIEW_MARGIN + self.startButton.bounds.size.width + UYLCOUNTERVIEW_MARGIN, UYLCOUNTERVIEW_MARGIN);
    counterElement.accessibilityFrame = [self convertRect:textFrame toView:nil];
    counterElement.accessibilityLabel = NSLocalizedString(@"Duration", nil);
    counterElement.accessibilityValue = [[NSNumber numberWithInteger:self.secondsCounter] stringValueAsTime];
    counterElement.accessibilityTraits = UIAccessibilityTraitUpdatesFrequently;

    [_accessibleElements addObject:counterElement];

    // stop button
    
    UIAccessibilityElement *stopElement = [[UIAccessibilityElement alloc] initWithAccessibilityContainer:self];
    stopElement.accessibilityFrame = [self convertRect:self.stopButton.frame toView:nil];
    stopElement.accessibilityLabel = NSLocalizedString(@"Stop", nil);
    stopElement.accessibilityTraits = UIAccessibilityTraitButton;
    if (self.stopButton.enabled == NO) stopElement.accessibilityTraits |= UIAccessibilityTraitNotEnabled;

    [_accessibleElements addObject:stopElement];

    return _accessibleElements;
}

- (BOOL)isAccessibilityElement
{
    return NO;
}

- (NSInteger)accessibilityElementCount
{
    return [[self accessibleElements] count];
}

- (id)accessibilityElementAtIndex:(NSInteger)index
{
    return [[self accessibleElements] objectAtIndex:index];
}

- (NSInteger)indexOfAccessibilityElement:(id)element
{
    return [[self accessibleElements] indexOfObject:element];
}

#pragma mark -
#pragma mark === Private methods ===
#pragma mark -

- (void)setupView
{
    UIImage *startImage = [UIImage imageNamed:@"start.png"];
    UIImage *stopImage = [UIImage imageNamed:@"stop.png"];
    
    CGRect startFrame = CGRectMake(UYLCOUNTERVIEW_MARGIN, (self.bounds.size.height - startImage.size.height)/2,
                                   startImage.size.height, startImage.size.width);
    CGRect stopFrame = CGRectMake(self.bounds.size.width - UYLCOUNTERVIEW_MARGIN - stopImage.size.width,
                                  (self.bounds.size.height - stopImage.size.height)/2,
                                  stopImage.size.height, stopImage.size.width);
    
    self.startButton = [[UIButton alloc] initWithFrame:startFrame];
    self.stopButton = [[UIButton alloc] initWithFrame:stopFrame];
    
    self.startButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    self.stopButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    [self.startButton setImage:startImage forState:UIControlStateNormal];
    [self.stopButton setImage:stopImage forState:UIControlStateNormal];
    
    [self.startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.stopButton addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.startButton.enabled = NO;
    self.stopButton.enabled = NO;
    
    [self addSubview:self.startButton];
    [self addSubview:self.stopButton];
}

@end
