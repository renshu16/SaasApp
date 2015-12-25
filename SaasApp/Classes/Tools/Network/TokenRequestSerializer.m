//
//  TokenRequestSerializer.m
//  SaasApp
//
//  Created by ToothBond on 15/11/9.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TokenRequestSerializer.h"
#import "StringUtils.h"

@implementation TokenRequestSerializer

-(NSDictionary *)transformRequestDictionaryWithInputDictionary:(NSDictionary *)inputDictionary
{
    NSDictionary * superDict = [super transformRequestDictionaryWithInputDictionary:inputDictionary];
    if ([superDict valueForKey:@"token"] == nil) {
        //NSString *token = [[UserManager sharedInstance] userToken];
        NSString *token = @"token";
        if (token && token.length > 0) {
            NSMutableDictionary *retDict = [NSMutableDictionary dictionaryWithDictionary:superDict];
            [retDict setObject:token forKey:@"token"];
            return retDict;
        }else{
            //token为空的情况，将异常抛出，由具体的Controller决定是否需要跳转登录页面
            return nil;
        }
    }
    
    return superDict;
}


@end
