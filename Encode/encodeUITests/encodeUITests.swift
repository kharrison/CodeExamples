//
//  encodeUITests.swift
//  encodeUITests
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

class encodeUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
  
    func testOutputUpdated() {
      let app = XCUIApplication()
      let input = "one two"
      let expectedRFC3986 = input.stringByAddingPercentEncodingForRFC3986()
      let expectedForm = input.stringByAddingPercentEncodingForFormData()
      
      let textToEncodeTextField = app.textFields["InputText"]
      textToEncodeTextField.tap()
      textToEncodeTextField.typeText("\(input)\r")
      
      let outputRFC3986  = app.staticTexts["RFC3968Output"]
      XCTAssertEqual(expectedRFC3986, outputRFC3986.label)
      
      let outputForm = app.staticTexts["FormOutput"]
      XCTAssertEqual(expectedForm, outputForm.label)
  }
  
  func testPlusForSpaceSwitch() {
    let app = XCUIApplication()
    let input = "one two"
    let expectedRFC3986 = input.stringByAddingPercentEncodingForRFC3986()
    let expectedForm = input.stringByAddingPercentEncodingForFormData()
    let expectedPlusForm = input.stringByAddingPercentEncodingForFormData(true)
    
    let textToEncodeTextField = app.textFields["InputText"]
    textToEncodeTextField.tap()
    textToEncodeTextField.typeText("\(input)\r")
    
    let outputRFC3986  = app.staticTexts["RFC3968Output"]
    XCTAssertEqual(expectedRFC3986, outputRFC3986.label)
    
    let outputForm = app.staticTexts["FormOutput"]
    XCTAssertEqual(expectedForm, outputForm.label)

    app.switches["PlusSwitch"].tap()
    XCTAssertEqual(expectedRFC3986, outputRFC3986.label)
    XCTAssertEqual(expectedPlusForm, outputForm.label)
    
    app.switches["PlusSwitch"].tap()
    XCTAssertEqual(expectedRFC3986, outputRFC3986.label)
    XCTAssertEqual(expectedForm, outputForm.label)
  }
}
