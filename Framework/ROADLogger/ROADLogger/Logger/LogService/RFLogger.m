//
//  RFLogger.m
//  ROADLogger
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

#import "RFLogger.h"

#import "RFLogMessage.h"
#import "RFLogWriter.h"
#import "RFConsoleLogWriter.h"

@implementation RFLogger {
    NSMutableArray *writers;
    RFConsoleLogWriter *internalWriter;
}

@synthesize logLevel = _logLevel;

- (id)init
{
    self = [super init];
    if (self) {
        writers = [[NSMutableArray alloc] init];
        internalWriter = [[RFConsoleLogWriter alloc] init];
    }
    return self;
}

- (void)addWriter:(RFLogWriter *const)aWriter {
    [writers addObject:aWriter];
}

- (void)removeWriter:(RFLogWriter *const)aWriter {
    [writers removeObject:aWriter];
}

- (void)logMessage:(RFLogMessage *const)message {
    NSArray * const immutable = [NSArray arrayWithArray:writers];
    
    for (RFLogWriter * const aWriter in immutable) {
        if ([aWriter hasMessagePassedFilters:message]) {
            [aWriter enqueueValidMessage:message];
        }
    }
}

- (void)setWriters:(NSArray *const)arrayOfWriters {
    writers = [NSMutableArray arrayWithArray:arrayOfWriters];
}

- (NSArray *)writers {
    return [NSArray arrayWithArray:writers];
}


#pragma mark - Logging methods

- (void)logInfoMessage:(NSString *const)messageText {
    [self logMessage:[RFLogMessage infoMessage:messageText]];
}

- (void)logDebugMessage:(NSString *const)messageText {
    [self logMessage:[RFLogMessage debugMessage:messageText]];
}

- (void)logWarningMessage:(NSString *const)messageText {
    [self logMessage:[RFLogMessage warningMessage:messageText]];
}

- (void)logErrorMessage:(NSString *const)messageText {
    [self logMessage:[RFLogMessage errorMessage:messageText]];
}

- (void)logInternalErrorMessage:(NSString *const)messageText {
    [internalWriter logValidMessage:[RFLogMessage errorMessage:messageText]];
}

- (void)logInfoMessage:(NSString *const)messageText type:(NSString *)type {
    RFLogMessage *message = [RFLogMessage infoMessage:messageText type:type];
    [self logMessage:message];
}

- (void)logDebugMessage:(NSString *const)messageText type:(NSString *)type {
    RFLogMessage *message = [RFLogMessage debugMessage:messageText type:type];
    [self logMessage:message];
}

- (void)logWarningMessage:(NSString *const)messageText type:(NSString *)type {
    RFLogMessage *message = [RFLogMessage warningMessage:messageText type:type];
    [self logMessage:message];
}

- (void)logErrorMessage:(NSString *const)messageText type:(NSString *)type {
    RFLogMessage *message = [RFLogMessage infoMessage:messageText type:type];
    [self logMessage:message];
}

@end
