//
//  TBCacheTool.m
//  SaasApp
//
//  Created by ToothBond on 15/12/2.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TBCacheTool.h"
#import "TBCacheObject.h"
#import "TBNetworkConfig.h"
#import "StringUtils.h"

@interface TBCacheTool ()

@property (nonatomic,strong)NSCache *cache;

@end

@implementation TBCacheTool

+ (instancetype)sharedInstance
{
    static TBCacheTool *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance = [[TBCacheTool alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public
- (NSData *)fetchCacheDataWithUrl:(NSString *)urlStr requestParams:(NSDictionary *)requestDict
{
    NSString *key = [self keyWithUrl:urlStr requestParams:requestDict];
    TBCacheObject *cacheObject = [self.cache objectForKey:key];
    if (cacheObject.isOutdated || cacheObject.isEmpty) {
        return nil;
    }else{
        return cacheObject.content;
    }
//    return cacheObject.content;
}

- (void)saveCacheWithData:(NSData *)cacheData url:(NSString *)urlStr requestParams:(NSDictionary *)requestDict
{
    NSString *key = [self keyWithUrl:urlStr requestParams:requestDict];
    TBCacheObject *cacheObject = [self.cache objectForKey:key];
    if (cacheObject == nil) {
        cacheObject = [[TBCacheObject alloc] init];
    }
    [cacheObject updateContent:cacheData];
    [self.cache setObject:cacheObject forKey:key];
}

#pragma mark - private
-(NSString *)keyWithUrl:(NSString *)urlStr requestParams:(NSDictionary *)requestDict
{
    NSString *keyStr = [NSString stringWithFormat:@"%@%@",urlStr,requestDict];
    DEBUG_NSLOG(@"cache key : %@",keyStr);
    DEBUG_NSLOG(@"md5 cache key : %@",[StringUtils MD5encode:keyStr]);
    return [StringUtils MD5encode:keyStr];
}

#pragma mark - getter
-(NSCache *)cache
{
    if (_cache == nil) {
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kTBCacheCountLimit;
    }
    return _cache;
}

@end
