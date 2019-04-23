//
//  UYLTableViewController.m
//  Restorer
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


#import "UYLTableViewController.h"
#import "UYLCountryViewController.h"

@interface UYLTableViewController () <UIDataSourceModelAssociation>
@property (strong, nonatomic) NSArray *worldData;
@end

@implementation UYLTableViewController

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -

- (NSArray *)worldData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"plist"];
    NSArray *countries = [[NSArray alloc] initWithContentsOfFile:plistPath];
    return countries;
}

#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    static NSString *UYLSegueShowCountry = @"UYLSegueShowCountry";

    if ([segue.identifier isEqualToString:UYLSegueShowCountry])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *country = [self.worldData objectAtIndex:indexPath.row];

        UYLCountryViewController *viewController = segue.destinationViewController;
        viewController.capital = [country valueForKey:@"capital"];
    }
}

#pragma mark -
#pragma mark === UITableViewDataSource Delegate Methods ===
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.worldData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UYLCountryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *country = [self.worldData objectAtIndex:indexPath.row];
    cell.textLabel.text = [country valueForKey:@"name"];
    return cell;
}

#pragma mark -
#pragma mark === State Preservation ===
#pragma mark -

- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)indexPath inView:(UIView *)view
{
    NSString *identifier = nil;
    if (indexPath && view)
    {
        NSDictionary *country = [self.worldData objectAtIndex:indexPath.row];
        identifier = [country valueForKey:@"name"];
    }
    return identifier;
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view
{
    NSIndexPath *indexPath = nil;
    if (identifier && view)
    {
        NSPredicate *namePred = [NSPredicate predicateWithFormat:@"name == %@", identifier];
        NSInteger row = [self.worldData indexOfObjectPassingTest:
                         ^(id obj, NSUInteger idx, BOOL *stop)
                         {
                             return [namePred evaluateWithObject:obj];
                         }];
        
        if (row != NSNotFound)
        {
            indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        }
    }
    
    // Force a reload when table view is embedded in nav controller
    // or scroll position is not restored. Uncomment following line
    // to workaround bug.
    [self.tableView reloadData];
    
    return indexPath;
}


@end
