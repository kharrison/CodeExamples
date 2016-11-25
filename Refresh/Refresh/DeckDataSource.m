//
//  DeckDataSource.m
//  Refresh
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2016 Keith Harrison. All rights reserved.
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


#import "DeckDataSource.h"

@interface DeckDataSource ()
@property (nonatomic, strong) NSMutableArray *deck;
@end

@implementation DeckDataSource

static const NSUInteger UYL_MAXOBJECTS = 52;

#pragma mark -
#pragma mark Custom Accessors
#pragma mark -

- (NSMutableArray *)deck
{
    if (_deck == nil)
    {
        _deck = [[NSMutableArray alloc] initWithCapacity:UYL_MAXOBJECTS];
        for (NSInteger index = 0; index < UYL_MAXOBJECTS; index++)
        {
            [_deck insertObject:@(index+1) atIndex:index];
        }
    }
    return _deck;
}

#pragma mark -
#pragma mark Public Interface
#pragma mark -

- (void)shuffle
{
    NSUInteger count = self.deck.count;

    if (count > 1)
    {
        for (NSUInteger i = count - 1; i > 0; --i)
        {
            [self.deck exchangeObjectAtIndex:i
                           withObjectAtIndex:arc4random_uniform((int32_t)(i + 1))];
        }
    }
}

#pragma mark -
#pragma mark UITableViewDataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deck.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.deck[indexPath.row]];
    return cell;
}

@end
