//
//  String+URLEncode.swift
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

import Foundation

/**
 A String extension that provides percent encoding of URL
 strings following RFC 3986 or the W3C HTML specification.
 */

extension String {
  
  /**
   Returns a new string made from the receiver by replacing characters which are
   reserved in a URI query with percent encoded characters.
   
   The following characters are not considered reserved in a URI query
   by RFC 3986:
   
   - Alpha "a...z" "A...Z"
   - Numberic "0...9"
   - Unreserved "-._~"
   
   In addition the reserved characters "/" and "?" have no reserved purpose in the
   query component of a URI so do not need to be percent escaped.
   
   - Returns: The encoded string, or nil if the transformation is not possible.
 */
  
  public func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~/?"
    let allowedCharacterSet = NSMutableCharacterSet.alphanumericCharacterSet()
    allowedCharacterSet.addCharactersInString(unreserved)
    return stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)
  }
  
  /**
   Returns a new string made from the receiver by replacing characters which are
   reserved in HTML forms (media type application/x-www-form-urlencoded) with
   percent encoded characters.
   
   The W3C HTML5 specification, section 4.10.22.5 URL-encoded form
   data percent encodes all characters except the following:
   
   - Space (0x20) is replaced by a "+" (0x2B)
   - Bytes in the range 0x2A, 0x2D, 0x2E, 0x30-0x39, 0x41-0x5A, 0x5F, 0x61-0x7A
     (alphanumeric + "*-._")

   - Parameter plusForSpace: Boolean, when true replaces space with a '+'
   otherwise uses percent encoding (%20). Default is false.
   
   - Returns: The encoded string, or nil if the transformation is not possible.
   */

  public func stringByAddingPercentEncodingForFormData(plusForSpace: Bool=false) -> String? {
    let unreserved = "*-._"
    let allowedCharacterSet = NSMutableCharacterSet.alphanumericCharacterSet()
    allowedCharacterSet.addCharactersInString(unreserved)
    
    if plusForSpace {
      allowedCharacterSet.addCharactersInString(" ")
    }
    
    var encoded = stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet)
    if plusForSpace {
      encoded = encoded?.stringByReplacingOccurrencesOfString(" ", withString: "+")
    }
    return encoded
  }
}
