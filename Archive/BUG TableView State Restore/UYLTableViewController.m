//
//  UYLTableViewController.m
//  restore
//
//  Created by Keith Harrison on 17/03/2013.
//  Copyright (c) 2013 Keith Harrison. All rights reserved.
//

#import "UYLTableViewController.h"

@interface UYLTableViewController () <UIDataSourceModelAssociation>

@end

@implementation UYLTableViewController

#pragma mark -
#pragma mark === UITableViewDataSource Delegate
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell #%d",indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark === State Preservation ===
#pragma mark -

// The following two methods are the suggested workaround from Apple to
// forse the table view state to be restored when embedded in a
// navigation controller. The key is to force the table view to
// reload data when the state has been restored.

//- (void) encodeRestorableStateWithCoder:(NSCoder *)coder
//{
//    // Save anything relevant for our role as the TableView's DataSource
//    [super encodeRestorableStateWithCoder:coder];
//}
//
//- (void) decodeRestorableStateWithCoder:(NSCoder *)coder
//{
//    [super decodeRestorableStateWithCoder:coder];
//    // Restore whatever we need as the TableView's DataSource, and then...
//    [self.tableView reloadData];
//}


// The following two methods are not strictly necessary in this simple example
// but you would normally want to implement any time the data displayed in the
// table view can change between saving and restoring the view.
//
// In this case we can also use this methods to force a reload of the table
// view data when restoring state. This is a workaround for a bug that causes
// the table view state to not be restored when embedded in a navigation controller.

- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)indexPath inView:(UIView *)view
{
    NSString *identifier = nil;
    if (indexPath && view)
    {
        identifier = [NSString stringWithFormat:@"%d",indexPath.row];
    }
    return identifier;
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view
{
    NSIndexPath *indexPath = nil;
    if (identifier && view)
    {
        NSInteger row = [identifier integerValue];
        indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    }
    
    // Force a reload when table view is embedded in nav controller
    // or scroll position is not restored. Uncomment following line
    // to workaround bug.
    // [self.tableView reloadData];
    
    return indexPath;
}

@end
