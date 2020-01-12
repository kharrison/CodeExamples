//
//  NewViewController.m
//
//  Created by Keith Harrison on 28/02/2011 http://useyourloaf.com
//  Copyright (c) 2011 Keith Harrison. All rights reserved.
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

#import "NewViewController.h"

@implementation NewViewController

@synthesize labelCellNib=_labelCellNib;

#pragma mark -
#pragma mark === Initialisation and Cleanup ===
#pragma mark -

- (void)viewDidUnload {
	[super viewDidUnload];
	self.labelCellNib = nil;
}

- (void)dealloc {
	[_labelCellNib release];
    [super dealloc];
}

- (id)labelCellNib {
	
	if (!_labelCellNib) {

		Class cls = NSClassFromString(@"UINib");
		if ([cls respondsToSelector:@selector(nibWithNibName:bundle:)]) {
			_labelCellNib = [[cls nibWithNibName:@"LabelCell" bundle:[NSBundle mainBundle]] retain];
		}
	}
	return _labelCellNib;
}

#pragma mark -
#pragma mark === Table View Delegates ===
#pragma mark -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"LabelCell";
	NSUInteger row = [indexPath row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		
		if ([self labelCellNib]) {
			[[self labelCellNib] instantiateWithOwner:self options:nil];
		} else {
			[[NSBundle mainBundle] loadNibNamed:@"LabelCell" owner:self options:nil];
		}

		cell = self.labelCell;
		self.labelCell = nil;
	}
	
	UILabel *label1 = (UILabel *)[cell viewWithTag:TCTAG_LABEL1];
	label1.text = [NSString stringWithFormat:@"Item %d", row+1];
	
	UILabel *label2 = (UILabel *)[cell viewWithTag:TCTAG_LABEL2];
	label2.text = [NSString stringWithFormat:@"Item %d", row+1];
	
	UILabel *label3 = (UILabel *)[cell viewWithTag:TCTAG_LABEL3];
	label3.text = [NSString stringWithFormat:@"Item %d", row+1];
	
    return cell;
}

@end
