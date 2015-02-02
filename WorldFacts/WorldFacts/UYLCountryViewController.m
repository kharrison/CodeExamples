//
//  UYLCountryViewController.m
//  WorldFacts
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2012-2014 Keith Harrison. All rights reserved.
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


#import "UYLCountryViewController.h"

@interface UYLCountryViewController ()

@property (nonatomic, weak) IBOutlet UILabel *area;
@property (nonatomic, weak) IBOutlet UILabel *capital;
@property (nonatomic, weak) IBOutlet UILabel *continent;
@property (nonatomic, weak) IBOutlet UILabel *currency;
@property (nonatomic, weak) IBOutlet UILabel *phone;
@property (nonatomic, weak) IBOutlet UILabel *population;
@property (nonatomic, weak) IBOutlet UILabel *tld;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *headlineCollection;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *bodyCollection;

@end

@implementation UYLCountryViewController

- (void)setCountry:(Country *)newCountry
{
    if (_country != newCountry)
    {
        _country = newCountry;
        [self configureView];
    }
}

- (void)configureView
{
    for (UILabel *label in self.headlineCollection)
    {
        label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    }
    
    for (UILabel *label in self.bodyCollection)
    {
        label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    
    self.title = self.country.name;
    
    NSString *area = [NSNumberFormatter localizedStringFromNumber:self.country.area numberStyle:NSNumberFormatterDecimalStyle];
    self.area.text = [area length] ? area : @"None";
    
    NSString *population = [NSNumberFormatter localizedStringFromNumber:self.country.population numberStyle:NSNumberFormatterDecimalStyle];
    self.population.text = [population length] ? population: @"None";
    
    self.capital.text = [self.country.capital length] ? self.country.capital : @"None";
    self.continent.text = [self.country.continent length] ? self.country.continent : @"None";
    self.currency.text = [self.country.currency length] ? self.country.currency : @"None";
    self.phone.text = [self.country.phone length] ? self.country.phone : @"None";
    self.tld.text = [self.country.tld length] ? self.country.tld : @"None";
}

#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)didChangePreferredContentSize:(NSNotification *)notification
{
    [self configureView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

@end
