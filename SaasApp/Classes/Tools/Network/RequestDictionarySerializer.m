//
//  RequestDictionarySerializer.m
//  SaasApp
//
//  Created by ToothBond on 15/11/6.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "RequestDictionarySerializer.h"
#import "TBNetworkConfig.h"

@implementation RequestDictionarySerializer

-(NSDictionary *)transformRequestDictionaryWithInputDictionary:(NSDictionary *)inputDictionary
{
    if ([inputDictionary valueForKey:@"version"] == nil) {
        NSMutableDictionary *retDict = [NSMutableDictionary dictionaryWithDictionary:inputDictionary];
        [retDict setObject:API_VERSION forKey:@"version"];
        return retDict;
    }
    
    return inputDictionary;
}

@end
