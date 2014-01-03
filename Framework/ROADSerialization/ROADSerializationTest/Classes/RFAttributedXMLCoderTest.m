//
//  RFAttributedXMLCoderTest.m
//  ROADSerialization
//
//  Created by Oleh Sannikov on 03.10.13.
//  Copyright (c) 2013 Epam Systems. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "RFAttributedXMLCoder.h"
#import "RFAttributedXMLDecoder.h"
#import "RFSerializationTestObject.h"
#import "RFXMLSerializationTestObject.h"
#import "RFXMLSerializationTestObject2.h"
#import <ROAD/ROADLogger.h>

@interface RFAttributedXMLCoderTest : SenTestCase {
    RFSerializationTestObject *_object;
    RFXMLSerializationTestObject *_object2;
    RFXMLSerializationTestObject2 *_object3;
    
    RFAttributedXMLDecoder *decoder;
    RFAttributedXMLCoder *coder;
}

@end

@implementation RFAttributedXMLCoderTest

- (void)setUp {

    [RFServiceProvider logger].logLevel = RFLogLevelDebug;
    
    decoder = [[RFAttributedXMLDecoder alloc] init];
    coder = [[RFAttributedXMLCoder alloc] init];
    
    _object = [RFSerializationTestObject sampleObject];
    _object2 = [RFXMLSerializationTestObject sampleObject];
    _object3 = [RFXMLSerializationTestObject2 sampleObject];
   
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testSimpleSerialization
{
    id objects = @[@1, @2, @"3", [NSDate date], @[@"string1", @"string2", @"string3"], @{@"myValue1" : @1, @"myValue2" : @2}];
    NSString *result = [coder encodeRootObject:objects];
    STAssertTrue([result length] > 0, @"Assertion: serialization of array is not successful.");
    
    NSError *decodeError = nil;
    id recreatedObjects = [decoder decodeData:[result dataUsingEncoding:NSUTF8StringEncoding] withRootObjectClass:nil error:&decodeError];
    STAssertNil(decodeError, @"XML Decoding Error: %@", decodeError);
    STAssertTrue([objects count] == [recreatedObjects count], @"Assertion: serialization is not successful.");
    
    RFSerializationTestObject *emptyObject = [[RFSerializationTestObject alloc] init];
    result = [coder encodeRootObject:emptyObject];
    STAssertTrue([result length] > 0, @"Assertion: serialization of empty test object is not successful.");
    
    RFSerializationTestObject *recreatedEmptyObject = [decoder decodeData:[result dataUsingEncoding:NSUTF8StringEncoding] withRootObjectClass:[RFSerializationTestObject class] error:&decodeError];
    STAssertNil(decodeError, @"XML Decoding Error: %@", decodeError);
    STAssertTrue([emptyObject isEqual:recreatedEmptyObject], @"Assertion: object is not equal to initial after serialization and deserialization.");
}

- (void)testSerialization
{
    NSString *string = [coder encodeRootObject:_object];
    NSError *decodeError = nil;

    RFSerializationTestObject *recreatedObject = [decoder decodeData:[string dataUsingEncoding:NSUTF8StringEncoding] withRootObjectClass:[RFSerializationTestObject class]error:&decodeError];
    STAssertNil(decodeError, @"XML Decoding Error: %@", decodeError);
    
    string = [coder encodeRootObject:recreatedObject];

    STAssertTrue([string length] > 0, @"Assertion: double serialization of test object is not successful.");
    STAssertTrue(![_object isEqual:recreatedObject], @"Assertion: object is equal to initial after serialization and deserialization.");
    
    // string2 is derived attribute
    recreatedObject.string2 = _object.string2;
    [recreatedObject.subDictionary[@"object3"] setString2:[_object.subDictionary[@"object3"] string2]];
    
    STAssertTrue([_object isEqual:recreatedObject], @"Assertion: object is not equal to initial after serialization and deserialization.");
}

- (void)testDeserializationFromFile
{
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *fileURL = [testBundle URLForResource:@"DeserialisationTest" withExtension:@"xml"];
    NSData *data = [NSData dataWithContentsOfURL:fileURL];

    NSError *decodeError = nil;
    id result = [decoder decodeData:data withRootObjectClass:[RFSerializationTestObject class] error:&decodeError];
    STAssertNil(decodeError, @"XML Decoding Error: %@", decodeError);
    STAssertTrue(result, @"Assertion: deserialization is not successful.");
}

- (void)testSerializationWithCollectionContainer
{
    NSError *decodeError = nil;
    NSString *string = [coder encodeRootObject:_object2];
    RFXMLSerializationTestObject *recreatedObject = [decoder decodeData:[string dataUsingEncoding:NSUTF8StringEncoding] withRootObjectClass:[RFXMLSerializationTestObject class] error:&decodeError];
    STAssertNil(decodeError, @"XML Decoding Error: %@", decodeError);
    
    string = [coder encodeRootObject:recreatedObject];
    STAssertTrue([string length] > 0, @"Assertion: double serialization of test object is not successful.");
    
    STAssertTrue(![_object2 isEqual:recreatedObject], @"Assertion: object is equal to initial after serialization and deserialization.");
    
    // string2 is derived attribute
    recreatedObject.string2 = _object2.string2;
    
    STAssertTrue([_object2 isEqual:recreatedObject], @"Assertion: object is not equal to initial after serialization and deserialization.");
}

- (void)testDeserializationWithCollectionContainer
{
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *fileURL = [testBundle URLForResource:@"DeserialisationCollectionContainerTest" withExtension:@"xml"];
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    
    NSError *decodeError = nil;
    RFXMLSerializationTestObject *result = [decoder decodeData:data withRootObjectClass:[RFXMLSerializationTestObject class] error:&decodeError];
    STAssertNil(decodeError, @"XML Decoding Error: %@", decodeError);

    result.string2 = _object2.string2;

    STAssertTrue([result isEqual:_object2], @"Assertion: deserialization is not successful.");
}

- (void)testDeserializationWithMixedCollectionContainer
{
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *fileURL = [testBundle URLForResource:@"DeserialisationMixedCollectionContainerTest" withExtension:@"xml"];
    NSData *data = [NSData dataWithContentsOfURL:fileURL];
    
    NSError *decodeError = nil;
    RFXMLSerializationTestObject2 *result = [decoder decodeData:data withRootObjectClass:[RFXMLSerializationTestObject2 class] error:&decodeError];
    STAssertNil(decodeError, @"XML Decoding Error: %@", decodeError);
    
    result.string2 = _object3.string2;
    
    STAssertTrue([result isEqual:_object3], @"Assertion: deserialization is not successful.");
    
    NSString *reencodedXML = [coder encodeRootObject:result];
    RFXMLSerializationTestObject2 *recreatedResult = [decoder decodeData:[reencodedXML dataUsingEncoding:NSUTF8StringEncoding] withRootObjectClass:[RFXMLSerializationTestObject2 class] error:&decodeError];
    STAssertNil(decodeError, @"XML Decoding Error: %@", decodeError);
    
    recreatedResult.string2 = _object3.string2;
    
    STAssertTrue([recreatedResult isEqual:_object3], @"Assertion: deserialization is not successful.");
}

@end
