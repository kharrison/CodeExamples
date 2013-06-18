//
//  UYLTableViewController.m
//  Refresh
//
//  Created by Keith Harrison on 17/06/2013.
//  Copyright (c) 2013 Keith Harrison. All rights reserved.
//

#import "UYLTableViewController.h"

@interface UYLTableViewController ()
@property (nonatomic,strong) NSMutableArray *deck;
@end

#define UYL_MAXOBJECTS 52

@implementation UYLTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ************************************************************************
    // With the UIRefreshControl added to the Storyboard the action is never
    // received unless we manually set the target-action here.
    //
    // To reproduce the bug comment the following line.
    // ************************************************************************

    // [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.deck count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.deck objectAtIndex:indexPath.row]];
    return cell;
}

- (IBAction)refresh:(id)sender
{
    [self shuffle];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)shuffle
{
	NSInteger count = [self.deck count];
	for (NSInteger i = 0; i < count; i++)
    {
		NSInteger position = random() % (count - i) + i;
		[self.deck exchangeObjectAtIndex:i withObjectAtIndex:position];
	}
}

- (NSMutableArray *)deck
{
    if (_deck == nil)
    {
        _deck = [[NSMutableArray alloc] initWithCapacity:UYL_MAXOBJECTS];
        for (NSInteger index = 0; index < UYL_MAXOBJECTS; index++)
        {
            [_deck insertObject:[NSNumber numberWithInteger:index+1] atIndex:index];
        }
    }
    return _deck;
}

@end
