//
//  UYLCountryViewController.m
//  WorldFacts
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


#import "UYLCountryViewController.h"

@interface UYLCountryViewController ()

@property (nonatomic, weak) IBOutlet UILabel *area;
@property (nonatomic, weak) IBOutlet UILabel *capital;
@property (nonatomic, weak) IBOutlet UILabel *continent;
@property (nonatomic, weak) IBOutlet UILabel *currency;
@property (nonatomic, weak) IBOutlet UILabel *phone;
@property (nonatomic, weak) IBOutlet UILabel *population;
@property (nonatomic, weak) IBOutlet UILabel *tld;

@end

@implementation UYLCountryViewController

@synthesize country=_country;
@synthesize area=_area;
@synthesize capital=_capital;
@synthesize continent=_continent;
@synthesize currency=_currency;
@synthesize phone=_phone;
@synthesize population=_population;
@synthesize tld=_tld;

#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.country.name;
    self.area.text = [NSNumberFormatter localizedStringFromNumber:self.country.area numberStyle:NSNumberFormatterDecimalStyle];
    self.population.text = [NSNumberFormatter localizedStringFromNumber:self.country.population numberStyle:NSNumberFormatterDecimalStyle];

    self.capital.text = self.country.capital;
    self.continent.text = self.country.continent;
    self.currency.text = self.country.currency;
    self.phone.text = self.country.phone;
    self.tld.text = self.country.tld;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
