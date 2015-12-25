//
//  RequestDictionarySerializer.h
//  SaasApp
//
//  Created by ToothBond on 15/11/6.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestDictionarySerialication <NSObject>

@required
-(NSDictionary *)transformRequestDictionaryWithInputDictionary:(NSDictionary *)inputDictionary;
@end

@interface RequestDictionarySerializer : NSObject<RequestDictionarySerialication>

@end
