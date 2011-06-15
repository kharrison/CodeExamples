//
//  SearchViewController.m
//  Created by Keith Harrison on 06-June-2011 http://useyourloaf.com
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

#import "SearchViewController.h"
#import "SBJSON.h"

@interface SearchViewController ()
- (void)loadQuery;
- (void)handleError:(NSError *)error;
@end

@implementation SearchViewController

@synthesize query=_query;
@synthesize connection=_connection;
@synthesize buffer=_buffer;
@synthesize results=_results;

#pragma mark -
#pragma mark === View Setup ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.query;
    [self loadQuery];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self.connection cancel];
    
    self.connection = nil;
    self.buffer = nil;
    self.results = nil;
}

- (void)dealloc
{
    [self.connection cancel];
    [_connection release];
    [_buffer release];
    [_results release];
    [_query release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark === UITableViewDataSource Delegates ===
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger count = [self.results count];
    return count > 0 ? count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ResultCellIdentifier = @"ResultCell";
    static NSString *LoadCellIdentifier = @"LoadingCell";
    
    NSUInteger count = [self.results count];
    if ((count == 0) && (indexPath.row == 0)) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadCellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                           reuseIdentifier:LoadCellIdentifier] autorelease];
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }
        
        if (self.connection) {
            cell.textLabel.text = @"Loading...";
        } else {
            cell.textLabel.text = @"Not available";
        }
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ResultCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:ResultCellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    
    NSDictionary *tweet = [self.results objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", [tweet objectForKey:@"from_user"],
                           [tweet objectForKey:@"text"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row & 1) {
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark -
#pragma mark === Private methods ===
#pragma mark -

#define RESULTS_PERPAGE 100

- (void)loadQuery {
    
    NSString *path = [NSString stringWithFormat:@"http://search.twitter.com/search.json?rpp=%d&q=%@",
                            RESULTS_PERPAGE,self.query];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    self.connection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    self.buffer = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [self.buffer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.connection = nil;
    
    NSString *jsonString = [[NSString alloc] initWithData:self.buffer encoding:NSUTF8StringEncoding];
    NSDictionary *jsonResults = [jsonString JSONValue];
    self.results = [jsonResults objectForKey:@"results"];
    
    [jsonString release];
    self.buffer = nil;
    [self.tableView reloadData];
    [self.tableView flashScrollIndicators];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.connection = nil;
    self.buffer = nil;
    
    [self handleError:error];
    [self.tableView reloadData];
}

- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error"                              
                                                        message:errorMessage
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

@end

