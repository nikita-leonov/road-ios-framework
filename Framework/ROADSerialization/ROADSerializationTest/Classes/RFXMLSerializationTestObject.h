//
//  RFXMLSerializationTestObject.h
//  ROADSerialization
//
//  Created by Oleh Sannikov on 15.11.13.
//  Copyright (c) 2013 Epam Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RFXMLSerializableCollection.h"
#import "RFXMLSerializable.h"

RF_ATTRIBUTE(RFSerializable)
@interface RFXMLSerializationTestObject : NSObject

RF_ATTRIBUTE(RFDerived)
@property (copy, nonatomic) NSString *string2;

RF_ATTRIBUTE(RFXMLSerializable, isTagAttribute = YES);
@property (copy, nonatomic) NSString *name;
RF_ATTRIBUTE(RFXMLSerializable, isTagAttribute = YES);
@property (copy, nonatomic) NSString *city;
RF_ATTRIBUTE(RFXMLSerializable, serializationKey = @"nm:age", isTagAttribute = YES);
@property (assign, nonatomic) int age;

RF_ATTRIBUTE(RFXMLSerializableCollection, collectionClass = [RFXMLSerializationTestObject class], itemTag = @"child")
@property (copy, nonatomic) NSArray *children;

+ (id)sampleObject;
- (BOOL)isContentEqual:(id)object;

@end
