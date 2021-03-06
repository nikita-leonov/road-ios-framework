//
//  NSString+RFAccessorUtilities.m
//  ROADCore
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
//
// See the NOTICE file and the LICENSE file distributed with this work
// for additional information regarding copyright ownership and licensing


#import "NSString+RFAccessorUtilities.h"

static NSString * const kRFSetterNameFormat = @"set%@:";
static NSString * const kRFSetterPrefix = @"set";
static NSString * const kRFBooleanGetterPrefix = @"is";
static NSString * const kRFCaseTransformationFormat = @"%@%@%@";

@implementation NSString (RFAccessorUtilities)

- (NSString *)RF_stringByTransformingToSetterAccessor {
    return [NSString stringWithFormat:kRFSetterNameFormat, [self RF_stringWithUpperCaseFirstCharacter]];
}

- (NSString *)RF_stringByTransformingToGetterAccessor {
    NSString *result;
    
    if ([self hasPrefix:kRFSetterPrefix]) {
        result = [[self substringWithRange:NSMakeRange([kRFSetterPrefix length], [self length]-([kRFSetterPrefix length] + 1))] RF_stringWithLowerCaseFirstCharacter];
    }
    else if ([self hasPrefix:kRFBooleanGetterPrefix]) {
        result = [[self substringWithRange:NSMakeRange([kRFBooleanGetterPrefix length], [self length]-([kRFBooleanGetterPrefix length] + 1))] RF_stringWithLowerCaseFirstCharacter];
    }
    return result;
}

// Creates a string from the receiver by transforming its first letter character into upper case
- (NSString *)RF_stringWithUpperCaseFirstCharacter {
    NSRange const range = [self rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    NSString * const subString = [[self substringWithRange:range] uppercaseString];
    NSString * const firstPart = [self substringToIndex:range.location];
    NSString * const lastPart = [self substringFromIndex:range.location + range.length];
    
    NSString * const result = [NSString stringWithFormat:kRFCaseTransformationFormat, firstPart, subString, lastPart];
    return result;
}

// Creates a string from the receiver by transforming its first letter character into lower case
- (NSString *)RF_stringWithLowerCaseFirstCharacter {
    NSRange const range = [self rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
    NSString * const subString = [[self substringWithRange:range] lowercaseString];
    NSString * const firstPart = [self substringToIndex:range.location];
    NSString * const lastPart = [self substringFromIndex:range.location + range.length];
    
    NSString * const result = [NSString stringWithFormat:kRFCaseTransformationFormat, firstPart, subString, lastPart];
    return result;
}

@end
