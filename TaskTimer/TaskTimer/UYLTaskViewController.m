//
//  UYLDetailViewController.m
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


#import "UYLTaskViewController.h"

@interface UYLTaskViewController ()

@property (assign, nonatomic) BOOL running;
@property (strong, nonatomic) NSTimer *taskTimer;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
- (void)saveContext;

@end

@implementation UYLTaskViewController

@synthesize task=_task;
@synthesize taskNote=_taskNote;
@synthesize taskCounterView=_taskCounterView;
@synthesize running=_running;
@synthesize taskTimer=_taskTimer;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -

- (void)setTask:(Task *)newTask
{
    if (_task != newTask)
    {
        _task = newTask;
        
        self.running = NO;
        self.taskTimer = nil;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)setTaskTimer:(NSTimer *)taskTimer
{
    [_taskTimer invalidate];
    _taskTimer = taskTimer;
}

#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Task", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.taskCounterView.delegate = self;
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.taskTimer = nil;
    [self saveContext];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.taskTimer = nil;
    [self saveContext];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // The accessibility elements should be recalculated when the orientation changes
    self.taskCounterView.accessibleElements = nil;
}

#pragma mark -
#pragma mark === Split View Delegate methods ===
#pragma mark -

- (BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return NO;
}

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Task List", nil);
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark -
#pragma mark === Text delegate methods ===
#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.task)
    {
        self.task.note = textField.text;
    }
	[textField resignFirstResponder];
	return YES;
}

#pragma mark -
#pragma mark === UYLCounterViewDelegate methods ===
#pragma mark -

- (void)didStartCounter
{
    self.running = YES;

    // Create a timer that fires every second.
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                      target:self
                                                    selector:@selector(timerTick:)
                                                    userInfo:nil
                                                     repeats:YES];
    self.taskTimer = timer;
}

- (void)didStopCounter
{
    if (self.task)
    {
        self.task.complete = [NSNumber numberWithBool:YES];
    }

    self.running = NO;
    self.taskTimer = nil;
    [self saveContext];
}

- (void)timerTick:(NSTimer *)timer
{
    if (self.running && self.task)
    {
        NSUInteger duration = [self.task.duration integerValue];
        duration++;
        
        self.task.duration = [NSNumber numberWithInteger:duration];
        self.taskCounterView.secondsCounter = duration;
    }
}

#pragma mark -
#pragma mark === Private methods ===
#pragma mark -

- (void)configureView
{
    NSInteger duration = 0;
    self.taskNote.enabled = NO;
    self.taskCounterView.counterEnabled = NO;
    self.taskNote.text = nil;
    
    if (self.task)
    {
        self.taskNote.enabled = YES;
        self.taskNote.text = self.task.note;
        duration = [self.task.duration integerValue];
        if ([self.task.complete boolValue] == NO)
        {
            self.taskCounterView.counterEnabled = YES;
        }
    }
    self.taskCounterView.secondsCounter = duration;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = [self.task managedObjectContext];
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        } 
    }
}

@end
