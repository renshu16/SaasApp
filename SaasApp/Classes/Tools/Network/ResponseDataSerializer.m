//
//  ResponseDataSerializer.m
//  SaasApp
//
//  Created by ToothBond on 15/11/6.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "ResponseDataSerializer.h"

@implementation ResponseDataSerializer

-(id)transformResponseDataWithInputData:(id)data
{
    
    id content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    if ([content isKindOfClass:[NSDictionary class]]) {
//        DEBUG_FUNC
//    }
    if (content) {
        return content;
    }
    
    return data;
}
@end
