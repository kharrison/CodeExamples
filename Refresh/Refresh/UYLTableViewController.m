//
//  UYLTableViewController.m
//  Refresh
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
