#import <Spark/SparkServices.h>
#import "SFConcreteWebServiceClient.h"
 
@interface SFServiceProvider(SFAttribute)
 
@end
 
@implementation SFServiceProvider(SFAttribute)
 
#pragma mark - Fill Attributes generated code (Methods section)

static NSMutableArray __weak *SF_attributes_list_SFServiceProvider_method_concreteWebServiceClient_p0 = nil;

+ (NSArray *)SF_attributes_SFServiceProvider_method_concreteWebServiceClient_p0 {
    if (SF_attributes_list_SFServiceProvider_method_concreteWebServiceClient_p0 != nil) {
        return SF_attributes_list_SFServiceProvider_method_concreteWebServiceClient_p0;
    }
    
    NSMutableArray *attributesArray = [NSMutableArray arrayWithCapacity:1];
    
    SFService *attr1 = [[SFService alloc] init];
    attr1.serviceClass = [SFConcreteWebServiceClient class];
    [attributesArray addObject:attr1];

    SF_attributes_list_SFServiceProvider_method_concreteWebServiceClient_p0 = attributesArray;
    
    return SF_attributes_list_SFServiceProvider_method_concreteWebServiceClient_p0;
}

static NSMutableDictionary __weak *attributesSFServiceProviderFactoriesForMethodsDict = nil;
    
+ (NSMutableDictionary *)SF_attributesFactoriesForMethods {
    if (attributesSFServiceProviderFactoriesForMethodsDict != nil) {
        return attributesSFServiceProviderFactoriesForMethodsDict;
    }
    
    NSMutableDictionary *dictionaryHolder = [super SF_attributesFactoriesForMethods];
    
    if (!dictionaryHolder) {
        dictionaryHolder = [NSMutableDictionary dictionary];
    }
    
    [dictionaryHolder setObject:[self SF_invocationForSelector:@selector(SF_attributes_SFServiceProvider_method_concreteWebServiceClient_p0)] forKey:@"concreteWebServiceClient"];
    attributesSFServiceProviderFactoriesForMethodsDict = dictionaryHolder;  
    
    return attributesSFServiceProviderFactoriesForMethodsDict;
}


#pragma mark - 

@end