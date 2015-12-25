//
//  TBCacheTool.h
//  SaasApp
//
//  Created by ToothBond on 15/12/2.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBCacheTool : NSObject

+ (instancetype)sharedInstance;

- (NSData *)fetchCacheDataWithUrl:(NSString *)urlStr requestParams:(NSDictionary *)requestDict;

- (void)saveCacheWithData:(NSData *)cacheData url:(NSString *)urlStr requestParams:(NSDictionary *)requestDict;

@end
