//
//  UYLAppDelegate.m
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


#import "UYLAppDelegate.h"
#import "UYLTaskListViewController.h"
#import "UYLTaskViewController.h"

@implementation UYLAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;

#pragma mark -
#pragma mark === Application Delegate Methods ===
#pragma mark -

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        UYLTaskListViewController *taskListViewController = [[UYLTaskListViewController alloc] initWithNibName:@"UYLTaskListViewController_iPhone" 
                                                                                                      bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:taskListViewController];
        self.window.rootViewController = self.navigationController;
        taskListViewController.managedObjectContext = self.managedObjectContext;
    }
    else
    {
        UYLTaskListViewController *taskListViewController = [[UYLTaskListViewController alloc] initWithNibName:@"UYLTaskListViewController_iPad" 
                                                                                                      bundle:nil];
        UINavigationController *taskListNavigationController = [[UINavigationController alloc] initWithRootViewController:taskListViewController];
        UYLTaskViewController *taskViewController = [[UYLTaskViewController alloc] initWithNibName:@"UYLTaskViewController_iPad" bundle:nil];
        UINavigationController *taskNavigationController = [[UINavigationController alloc] initWithRootViewController:taskViewController];
    	taskListViewController.detailViewController = taskViewController;
        
        self.splitViewController = [[UISplitViewController alloc] init];
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:taskListNavigationController, taskNavigationController, nil];
        self.splitViewController.delegate = taskViewController;
        
        self.window.rootViewController = self.splitViewController;
        taskListViewController.managedObjectContext = self.managedObjectContext;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self saveContext];
}

#pragma mark -
#pragma mark === Core Data Accessors ===
#pragma mark -

- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) 
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) 
    {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TaskTimer" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TaskTimer.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark -
#pragma mark === Utility Methods ===
#pragma mark -

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        } 
    }
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
