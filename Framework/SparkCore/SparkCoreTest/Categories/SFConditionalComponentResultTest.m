//
//  SFConditionalComponentResultTest.m
//  SparkCore
//
//  Copyright (c) 2013 Epam Systems. All rights reserved.
//
// Redistribution and use in source and binary forms, with or without 
// modification, are permitted provided that the following conditions are met:
// 
//  Redistributions of source code must retain the above copyright notice, this 
// list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this 
// list of conditions and the following disclaimer in the documentation and/or 
// other materials provided with the distribution.
//  Neither the name of the EPAM Systems, Inc.  nor the names of its contributors 
// may be used to endorse or promote products derived from this software without 
// specific prior written permission.
// 
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE 
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL 
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


#import "SFConditionalComponentResultTest.h"
#import "NSArray+EmptyArrayChecks.h"

@implementation SFConditionalComponentResultTest

- (void)testConditionalLastObjectNotExisting {
    NSArray * const array = @[];
    id lastObject = [array lastElementIfNotEmpty];
    
    STAssertTrue(lastObject == nil, @"Assertion: empty array's last object is nil with this method.");
}

- (void)testConditionalLastObjectExisting {
    NSArray * const array = @[@"first", @"second"];
    id lastObject = [array lastElementIfNotEmpty];
    
    STAssertTrue([lastObject isEqual:[array lastObject]], @"Assertion: lastObject method returns the same as the conditional version.");
}

- (void)testConditionalObjectAtIndexNotExisting {
    NSArray * const array = @[];
    id object = [array elementAtIndexIfInRange:[array count]];
    
    STAssertTrue(object == nil, @"Assertion: conditional returns nil for invalid index");
}

- (void)testConditionalObjectAtIndexExisting {
    NSArray * const array = @[@"first", @"second"];
    id object = [array elementAtIndexIfInRange:0];
    
    STAssertTrue([object isEqual:[array objectAtIndex:0]], @"Assertion: objectAtIndex method returns the same as the conditional version.");
}

- (void)testObjectMatching {
    NSArray * const array = @[@"first", @"second"];
    id object = [array elementWithPredicateBlock:^BOOL(NSString *evaluatedObject) {
        return [evaluatedObject isEqualToString:@"first"];
    }];
    
    STAssertTrue(object != nil, @"Assertion: matching returns valid result.");
}

@end