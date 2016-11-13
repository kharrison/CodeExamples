//
//  OptionViewController.m
//  KeyCommand
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

#import "OptionViewController.h"
#import "DetailViewController.h"
#import "UYLPriority.h"

@implementation OptionViewController

// Override keyCommands and return the three
// key commands for this view controller.

static NSString *inputKeyLow = @"1";
static NSString *inputKeyMedium = @"2";
static NSString *inputKeyHigh = @"3";

- (NSArray<UIKeyCommand *> *)keyCommands {
    return @[
             [UIKeyCommand keyCommandWithInput:inputKeyLow
                                 modifierFlags:UIKeyModifierCommand
                                        action:@selector(performCommand:)
                          discoverabilityTitle:NSLocalizedString(@"LowPriority", @"Low priority")],
             [UIKeyCommand keyCommandWithInput:inputKeyMedium
                                 modifierFlags:UIKeyModifierCommand
                                        action:@selector(performCommand:)
                          discoverabilityTitle:NSLocalizedString(@"MediumPriority", @"Medium priority")],
             [UIKeyCommand keyCommandWithInput:inputKeyHigh
                                 modifierFlags:UIKeyModifierCommand
                                        action:@selector(performCommand:)
                          discoverabilityTitle:NSLocalizedString(@"HighPriority", @"High priority")]
             ];
}

- (void)performCommand:(UIKeyCommand *)sender {
    NSString *key = sender.input;
    if ([key isEqualToString:inputKeyLow]) {
        [self performSegueWithIdentifier:UYLPriorityIdentifierLow sender:self];
    } else if ([key isEqualToString:inputKeyMedium]) {
        [self performSegueWithIdentifier:UYLPriorityIdentifierMedium sender:self];
    } else if ([key isEqualToString:inputKeyHigh]) {
        [self performSegueWithIdentifier:UYLPriorityIdentifierHigh sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = segue.destinationViewController;

        if ([navController.topViewController isKindOfClass:[DetailViewController class]]) {
            DetailViewController *viewController = (DetailViewController *)navController.topViewController;
            viewController.priority = [UYLPriority priorityLevelForIdentifier:segue.identifier];
        }
    }
}

// You can also add key commands without overriding the
// keyCommands property. For example you could call the
// following function from viewDidLoad:

//- (void)setupCommands {
//    UIKeyCommand *lowCommand = [UIKeyCommand keyCommandWithInput:inputKeyLow
//                                                   modifierFlags:UIKeyModifierCommand
//                                                          action:@selector(performCommand:)
//                                            discoverabilityTitle:NSLocalizedString(@"LowPriority", @"Low priority")];
//    [self addKeyCommand:lowCommand];
//
//    UIKeyCommand *mediumCommand = [UIKeyCommand keyCommandWithInput:inputKeyMedium
//                                                      modifierFlags:UIKeyModifierCommand
//                                                             action:@selector(performCommand:) discoverabilityTitle:NSLocalizedString(@"MediumPriority", @"Medium priority")];
//    [self addKeyCommand:mediumCommand];
//
//    UIKeyCommand *highCommand = [UIKeyCommand keyCommandWithInput:inputKeyHigh
//                                                    modifierFlags:UIKeyModifierCommand
//                                                           action:@selector(performCommand:) discoverabilityTitle:NSLocalizedString(@"HighPriority", @"High priority")];
//    [self addKeyCommand:highCommand];
//}

@end
