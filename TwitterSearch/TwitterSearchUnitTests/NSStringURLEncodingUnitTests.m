//
//  NSStringURLEncodingUnitTests.m
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

#import "NSString+URLEncoding.h"
#import <XCTest/XCTest.h>

@interface NSStringURLEncodingUnitTests : XCTestCase

@end

@implementation NSStringURLEncodingUnitTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testQueryAllowed {
  NSString *input = @"ABC123abc";
  NSString *output = [input stringByAddingPercentEncodingForURLQuery:NO];
  NSString *expected = @"ABC123abc";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testFormAllowed {
  NSString *input = @"ABC123abc";
  NSString *output = [input stringByAddingPercentEncodingForURLFormData];
  NSString *expected = @"ABC123abc";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testQuerySpaceIsPercentEncoded {
  NSString *input = @"one two";
  NSString *output = [input stringByAddingPercentEncodingForURLQuery:NO];
  NSString *expected = @"one%20two";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testQuerySpaceIsPlusEncoded {
  NSString *input = @"one two";
  NSString *output = [input stringByAddingPercentEncodingForURLQuery:YES];
  NSString *expected = @"one+two";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testFormSpaceIsPlusEncoded {
  NSString *input = @"one two";
  NSString *output = [input stringByAddingPercentEncodingForURLFormData];
  NSString *expected = @"one+two";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testQueryPlusIsEncodedWhenUsingPlusForSpaces {
  NSString *input = @"one+two";
  NSString *output = [input stringByAddingPercentEncodingForURLQuery:YES];
  NSString *expected = @"one%2Btwo";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testQueryPercentIsEncoded {
  NSString *input = @"%";
  NSString *output = [input stringByAddingPercentEncodingForURLQuery:NO];
  NSString *expected = @"%25";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testFormPercentIsEncoded {
  NSString *input = @"%";
  NSString *output = [input stringByAddingPercentEncodingForURLFormData];
  NSString *expected = @"%25";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testQueryReservedEncoded {
  NSString *input = @"!#$&'()*+,/:;=?@[]";
  NSString *output = [input stringByAddingPercentEncodingForURLQuery:NO];
  NSString *expected = @"%21%23%24%26%27%28%29%2A%2B%2C%2F%3A%3B%3D%3F%40%5B%5D";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testFormReservedEncoded {
  NSString *input = @"!#$&'()+,/:;=?@[]";
  NSString *output = [input stringByAddingPercentEncodingForURLFormData];
  NSString *expected = @"%21%23%24%26%27%28%29%2B%2C%2F%3A%3B%3D%3F%40%5B%5D";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testQueryUnreservedNotEncoded {
  NSString *input = @"-._~";
  NSString *output = [input stringByAddingPercentEncodingForURLQuery:NO];
  NSString *expected = @"-._~";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testFormUnreservedNotEncoded {
  NSString *input = @"-._*";
  NSString *output = [input stringByAddingPercentEncodingForURLFormData];
  NSString *expected = @"-._*";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

- (void)testFormTidleEncoded {
  NSString *input = @"~";
  NSString *output = [input stringByAddingPercentEncodingForURLFormData];
  NSString *expected = @"%7E";
  BOOL result = [expected isEqualToString:output];
  XCTAssertTrue(result, "Expected: %@ got %@",expected,output);
}

@end
