//
//  NSString+URLEncoding.h
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2015 Keith Harrison. All rights reserved.
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


#import <Foundation/Foundation.h>

/**
 An NSString category that provides percent encoding of URL
 strings.
 */

@interface NSString (URLEncoding)

/**--------------------------------------
 * @name Instance Methods
 * --------------------------------------
 */

/**
 Returns a new string made from the receiver by replacing characters which are
 reserved in a URL query with percent encoded characters (see RFC 3986).
 
 @param plusForSpace A boolean flag which when set replaces spaces by a '+'
 otherwise they are percent escaped as %20.
 
 @return Returns the encoded string, or nil if the transformation is not possible.
 */

- (nullable NSString *)stringByAddingPercentEncodingForURLQuery:(BOOL)plusForSpace;

/**
 Returns a new string made from the receiver by replacing characters which are
 reserved in a URL encoded form with percent encoded characters.
 
 @discussion Unlike -stringByAddingPercentEncodingForURLQuery: this method
 does not escape '*', spaces are always replaced by '+' and the '~' is not
 an allowed character so it is percent escaped.
 
 @return Returns the encoded string, or nil if the transformation is not possible.
 */

- (nullable NSString *)stringByAddingPercentEncodingForURLFormData;
@end
