//
//  UYLTaskViewController.m
//  ToDoSync
//
//  Created by Keith Harrison on 29-Oct-2011 http://useyourloaf.com
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


#import "UYLTaskViewController.h"
#import "Task.h"

@implementation UYLTaskViewController

@synthesize task = _task;
@synthesize taskTitle = _taskTitle;
@synthesize taskNotes = _taskNotes;
@synthesize taskCreated = _taskCreated;

@synthesize dateFormatter = _dateFormatter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Task", @"Task");
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
}

- (void)viewDidUnload
{
    [self setDateFormatter:nil];
    [self setTaskTitle:nil];
    [self setTaskNotes:nil];
    [self setTaskCreated:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.taskTitle.text = self.task.title;
    self.taskNotes.text = self.task.note;
    self.taskCreated.text = [self.dateFormatter stringFromDate:self.task.createdAt];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc
{
    [_dateFormatter release];
    [_task release];
    [_taskTitle release];
    [_taskNotes release];
    [_taskCreated release];
    [super dealloc];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    
    [super setEditing:editing animated:animated];
    
	self.taskTitle.enabled = editing;
	self.taskNotes.enabled = editing;
	[self.navigationItem setHidesBackButton:editing animated:YES];

	if (!editing)
    {
		NSManagedObjectContext *context = self.task.managedObjectContext;
		NSError *error = nil;
		if (![context save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		}
	}
}

#pragma mark -
#pragma mark === Text delegate methods ===
#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
	[textField resignFirstResponder];
	return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.taskTitle)
    {
        self.task.title = textField.text;
    }
    if (textField == self.taskNotes)
    {
        self.task.note = textField.text;
    }
}

@end
