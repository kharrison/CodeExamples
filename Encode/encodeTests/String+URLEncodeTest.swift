//
//  String+URLEncodeTest.swift
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

import XCTest

class URLEncodeTest: XCTestCase {
    
  override func setUp() {
    super.setUp()
  }
    
  override func tearDown() {
    super.tearDown()
  }
    
  func testRFC3986AlphaNumericNotEncoded() {
    let input = "abcdefghijklmnopqrstuvwxyz" +
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
                "0123456789"
    let output = input.stringByAddingPercentEncodingForRFC3986()
    XCTAssertEqual(input, output)
  }
  
  func testFormAlphaNumericNotEncoded() {
    let input = "abcdefghijklmnopqrstuvwxyz" +
                "ABCDEFGHIJKLMNOPQRSTUVWXYZ" +
                "0123456789"
    let output = input.stringByAddingPercentEncodingForFormData()
    XCTAssertEqual(input, output)
  }

  func testRFC3986UnreservedNotEncoded() {
    let input = "-._~"
    let output = input.stringByAddingPercentEncodingForRFC3986()
    XCTAssertEqual(input, output)
  }

  func testRFC3986SlashQuestionNotEncoded() {
    let input = "/?"
    let output = input.stringByAddingPercentEncodingForRFC3986()
    XCTAssertEqual(input, output)
  }

  func testFormUnreservedNotEncoded() {
    let input = "*-._"
    let output = input.stringByAddingPercentEncodingForFormData()
    XCTAssertEqual(input, output)
  }

  func testQuerySpacePercentEncoded() {
    let input = "one two"
    let output = input.stringByAddingPercentEncodingForRFC3986()
    let expected = "one%20two"
    XCTAssertEqual(expected, output)
  }

  func testFormSpacePercentEncoded() {
    let input = "one two"
    let output = input.stringByAddingPercentEncodingForFormData()
    let expected = "one%20two"
    XCTAssertEqual(expected, output)
  }

  func testFormSpacePlusEncoded() {
    let input = "one two"
    let output = input.stringByAddingPercentEncodingForFormData(true)
    let expected = "one+two"
    XCTAssertEqual(expected, output)
  }

  func testFormPlusIsPercentEncoded() {
    let input = "one+two"
    let output = input.stringByAddingPercentEncodingForFormData(true)
    let expected = "one%2Btwo"
    XCTAssertEqual(expected, output)
  }

  func testQueryPercentPercentEncoded() {
    let input = "%"
    let output = input.stringByAddingPercentEncodingForRFC3986()
    let expected = "%25"
    XCTAssertEqual(expected, output)
  }
  
  func testFormPercentPercentEncoded() {
    let input = "%"
    let output = input.stringByAddingPercentEncodingForFormData()
    let expected = "%25"
    XCTAssertEqual(expected, output)
  }

  func testQueryReservedPercentEncoded() {
    let input = "!#$&'()*+,:;=@[]"
    let output = input.stringByAddingPercentEncodingForRFC3986()
    let expected = "%21%23%24%26%27%28%29%2A%2B%2C%3A%3B%3D%40%5B%5D"
    XCTAssertEqual(expected, output)
  }

  func testFormReservedPercentEncoded() {
    let input = "!#$&'()+,/:;=?@[]"
    let output = input.stringByAddingPercentEncodingForFormData()
    let expected = "%21%23%24%26%27%28%29%2B%2C%2F%3A%3B%3D%3F%40%5B%5D"
    XCTAssertEqual(expected, output)
  }
}
