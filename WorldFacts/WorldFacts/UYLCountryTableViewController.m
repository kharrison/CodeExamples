//
//  UYLCountryTableViewController.m
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


#import "UYLCountryTableViewController.h"
#import "Country+Extensions.h"

@interface UYLCountryTableViewController () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSNumberFormatter *decimalFormatter;

// The following two properties are no longer required with iOS 5 since
// we can directly register a NIB with the table view or use a stroyboard
// to create the table view and load the cell NIB for us.

@property (strong, nonatomic) UINib *countryCellNib;
@property (strong, nonatomic) IBOutlet UITableViewCell *countryCell;

@end

@implementation UYLCountryTableViewController

@synthesize managedObjectContext=__managedObjectContext;
@synthesize fetchedResultsController=__fetchedResultsController;
@synthesize decimalFormatter=_decimalFormatter;
@synthesize countryCellNib=_countryCellNib;
@synthesize countryCell=_countryCell;

static NSString *UYLCountryCellIdentifier = @"UYLCountryCellIdentifier";

#define UYL_COUNTRYCELLTAG_NAME     100
#define UYL_COUNTRYCELLTAG_CAPITAL  200
#define UYL_COUNTRYCELLTAG_POP      300

#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"World", @"World");

//    UINib *countryNib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
//    [self.tableView registerNib:countryNib forCellReuseIdentifier:UYLCountryCellIdentifier];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.decimalFormatter = nil;
    self.countryCellNib = nil;
    self.countryCell = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -

- (NSNumberFormatter *)decimalFormatter
{
    if (!_decimalFormatter)
    {
        _decimalFormatter = [[NSNumberFormatter alloc] init];
        [_decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];        
    }
    return _decimalFormatter;
}

// The following accessor is no longer required with iOS 5 and was only 
// included to provide an example of iOS 4 usage of UINib to load anc
// cache the table view cell NIB.

- (UINib *)countryCellNib
{
    if (!_countryCellNib)
    {
        _countryCellNib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
    }
    return _countryCellNib;
}

#pragma mark -
#pragma mark === UITableViewDataSource Delegate Methods ===
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UYLCountryCellIdentifier];
    
    // The following code is now removed as with iOS 5 we can either
    // register a NIB or use a Storyboard to load our custom cells.
    
    if (cell == nil)
    {
        // For iOS 4 we could use UINib to load and cache our table view cell and
        // instantiate new instances. Prior to UINib it was necessary to load
        // the cell Nib file each time:
        // [[NSBundle mainBundle] loadNibNamed:@"CountryCell" owner:self options:nil];
        
        [self.countryCellNib instantiateWithOwner:self options:nil];
        cell = self.countryCell;
        self.countryCell = nil;
    }
    
    Country *country = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:UYL_COUNTRYCELLTAG_NAME];
    nameLabel.text = country.name;

    UILabel *capLabel = (UILabel *)[cell viewWithTag:UYL_COUNTRYCELLTAG_CAPITAL];
    capLabel.text = country.capital;

    UILabel *popLabel = (UILabel *)[cell viewWithTag:UYL_COUNTRYCELLTAG_POP];
    NSString *population = [self.decimalFormatter stringFromNumber:country.population];
    popLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Pop: %@", @"Pop:"), population];   
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo name];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

#pragma mark -
#pragma mark === Fetched Results Controller ===
#pragma mark -

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil)
    {
        return __fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:self.managedObjectContext 
                                                                            sectionNameKeyPath:@"sectionTitle"
                                                                                     cacheName:@"Country"];
    frc.delegate = self;
    self.fetchedResultsController = frc;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    
    return __fetchedResultsController;
}    

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
