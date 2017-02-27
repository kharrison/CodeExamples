//
//  LocationTests.swift
//  Container
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2017 Keith Harrison. All rights reserved.
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
import CoreLocation

@testable import Container

class LocationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitFromDictionary() {
        let australia = Location(dictionary: ["name" : "Australia",
                                              "latitude" : "-25",
                                              "longitude" : "135"])
        XCTAssertNotNil(australia)
        XCTAssert(australia?.name == "Australia")
        XCTAssert(australia?.latitude == -25.0)
        XCTAssert(australia?.longitude == 135.0)
    }

    func testMissingName() {
        let australia = Location(dictionary: ["latitude" : "-25",
                                              "longitude" : "135"])
        XCTAssertNil(australia)
    }

    func testMissingLatitude() {
        let australia = Location(dictionary: ["name" : "Australis",
                                              "longitude" : "135"])
        XCTAssertNil(australia)
    }

    func testMissingLongitude() {
        let australia = Location(dictionary: ["name" : "Australis",
                                              "latitude" : "-25"])
        XCTAssertNil(australia)
    }

    func testExtraKeysIgnored() {
        let australia = Location(dictionary: ["name" : "Australia",
                                              "latitude" : "-25",
                                              "longitude" : "135",
                                              "capital" : "Canberra"])
        XCTAssertNotNil(australia)
    }

    func testInvalidLatitude() {
        let australia = Location(dictionary: ["name" : "Australia",
                                              "latitude" : "hello",
                                              "longitude" : "135"])
        XCTAssertNil(australia)
    }

    func testInvalidLongitude() {
        let australia = Location(dictionary: ["name" : "Australia",
                                              "latitude" : "-25",
                                              "longitude" : "12a"])
        XCTAssertNil(australia)
    }

    func testInvalidCoordinare() {
        let nowhere = Location(dictionary: ["name" : "OffTheGrid",
                                              "latitude" : "-100",
                                              "longitude" : "200"])
        XCTAssertNil(nowhere)
    }
}
