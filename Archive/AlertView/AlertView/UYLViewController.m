//
//  UYLViewController.m
//  AlertView
//
//  Created by Keith Harrison on 13-Dec-2011 http://useyourloaf.com
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

#import "UYLViewController.h"

@implementation UYLViewController


#pragma mark -
#pragma mark === Button Action Methods ===
#pragma mark -

- (IBAction)showDefaultAlertView:(id)sender {

    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"DefaultStyle" 
                                                        message:@"the default alert view style"
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"OK", nil];
    
    [alertView show];
}

- (IBAction)showSecureTextAlertView:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SecureTextStyle" 
                                                        message:@"Enter secure text"
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"OK", nil];
    
    alertView.alertViewStyle = UIAlertViewStyleSecureTextInput;
    [alertView show];
}

- (IBAction)showPlainTextAlertView:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"PlainTextStyle" 
                                                        message:@"Enter plain text"
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"OK", nil];
    
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (IBAction)showLoginPassAlertView:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"LoginAndPaswordStyle" 
                                                        message:@"Enter login and password"
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"OK", nil];
    
    alertView.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alertView show];
}

#pragma mark -
#pragma mark === UIActionViewDelegate Methods ===
#pragma mark -

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Alert View dismissed with button at index %d",buttonIndex);
    
    switch (alertView.alertViewStyle)
    {
        case UIAlertViewStylePlainTextInput:
        {
            UITextField *textField = [alertView textFieldAtIndex:0];
            NSLog(@"Plain text input: %@",textField.text);
        }
        break;
            
        case UIAlertViewStyleSecureTextInput:
        {
            UITextField *textField = [alertView textFieldAtIndex:0];
            NSLog(@"Secure text input: %@",textField.text);
        }
        break;
            
        case UIAlertViewStyleLoginAndPasswordInput:
        {
            UITextField *loginField = [alertView textFieldAtIndex:0];
            NSLog(@"Login input: %@",loginField.text);
            
            UITextField *passwordField = [alertView textFieldAtIndex:1];
            NSLog(@"Password input: %@",passwordField.text);
        }
        break;
            
        default:
            break;
    }
}

- (BOOL)alertViewShouldEnableFirstOtherButton:(UIAlertView *)alertView
{
    UIAlertViewStyle style = alertView.alertViewStyle;
    
    if ((style == UIAlertViewStyleSecureTextInput) ||
        (style == UIAlertViewStylePlainTextInput) ||
        (style == UIAlertViewStyleLoginAndPasswordInput))
    {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if ([textField.text length] == 0)
        {
            return NO;
        }
    }
    
    return YES;
}
@end
