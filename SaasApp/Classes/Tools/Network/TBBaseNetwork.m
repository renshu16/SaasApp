//
//  TBBaseNetwork.m
//  SaasApp
//
//  Created by ToothBond on 15/11/4.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TBBaseNetwork.h"
#import "UIKit+AFNetworking.h"
#import "TBNetworkConfig.h"
#import "JSONKit.h"
#import "TBResponse.h"
#import "TBCacheTool.h"
#import "StringUtils.h"
#import "NSString+TBString.h"

typedef enum : NSUInteger{
    DEALLOC_CANCEL,
    USER_CANCEL,
}TBCancelType;

static AFHTTPRequestOperationManager *_managerReachability = nil;
static BOOL _canSendMessage = YES;

@interface TBBaseNetwork()

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)AFHTTPRequestOperation *httpOperation;
@property(nonatomic)    TBCancelType cancelType;


/**
 *  默认设置
 */
-(void)defaultConfig;

/**
 *  初始化网络状态监测
 */
+ (void)networkReachability;
@end

@implementation TBBaseNetwork

#pragma mark - 网络状态监控
+(void)initialize
{
    if (self == [TBBaseNetwork class]) {
        [self showNetworkActivityIndicator:YES];
        
        [self networkReachability];
        
        [self startMonitoring];
    }
}

+(void)showNetworkActivityIndicator:(BOOL)isShow
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:isShow];
}

+(void)networkReachability
{
    NSURL *baseURL = [NSURL URLWithString:TBBaseURL];
    _managerReachability = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    NSOperationQueue *operationQueue = _managerReachability.operationQueue;
    [_managerReachability.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [operationQueue setSuspended:NO];
                
                if (_canSendMessage == YES) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingReachability
                                                                        object:nil
                                                                      userInfo:@{@"networkReachable": NetworkingStatus_WWAN}];
                }
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                
                if (_canSendMessage == YES) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingReachability
                                                                        object:nil
                                                                      userInfo:@{@"networkReachable": NetworkingStatus_WIFI}];
                }
                
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                
                if (_canSendMessage == YES) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:NetworkingReachability
                                                                        object:nil
                                                                      userInfo:@{@"networkReachable": NetworkingStatus_NotReachable}];
                }
                
                break;
        }
    }];
}

+(void)startMonitoring
{
    _canSendMessage = YES;
    [_managerReachability.reachabilityManager startMonitoring];
}

+(void)stopMonitoring
{
    _canSendMessage = NO;
    [_managerReachability.reachabilityManager stopMonitoring];
}

+(BOOL)isReachable
{
    return _managerReachability.reachabilityManager.isReachable;
}

+ (BOOL)isReachableViaWWAN
{
    return _managerReachability.reachabilityManager.isReachableViaWWAN;
}

+ (BOOL)isReachableViaWIFI
{
    return _managerReachability.reachabilityManager.isReachableViaWiFi;
}

#pragma  mark - 初始化
-(instancetype) init
{
    self = [super init];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

-(void)defaultConfig
{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.isRunning = NO;
}

#pragma mark 构造方法
+(instancetype)networkingWithUrlString:(NSString *)urlString
                     requestDictionary:(NSDictionary *)requestDictionary
                              delegate:(id<TBBaseNetworkProrocol>)delegate
                       timeoutInterval:(NSNumber *)timeoutInterval
                                  flag:(NSInteger )flag
                         requestMethod:(AFNetworkRequestMethod)requestMethod
                  urlRequestSerializer:(id<AFURLRequestSerialization>)requestSerializer
                 urlResponseSerializer:(id<AFURLResponseSerialization>)responseSerializer
{
    TBBaseNetwork *aiyaApi     = [[TBBaseNetwork alloc]init];
    aiyaApi.urlString          = [NSString stringWithFormat:@"%@%@",TBBaseURL,urlString];
    aiyaApi.requestDictionary  = requestDictionary;
    aiyaApi.timeoutInterval    = timeoutInterval;
    aiyaApi.flag               = flag;
    aiyaApi.delegate           = delegate;
    aiyaApi.requestMethod      = requestMethod;
    aiyaApi.requestSerializer  = requestSerializer;
    aiyaApi.responseSerializer = responseSerializer;
    
    return aiyaApi;
}

+(instancetype)networkingWithUrlString:(NSString *)urlString
                     requestDictionary:(NSDictionary *)requestDictionary
                              delegate:(id<TBBaseNetworkProrocol>)delegate
{
    return [[self class] networkingWithUrlString:urlString
                               requestDictionary:requestDictionary
                                        delegate:delegate
                                 timeoutInterval:nil
                                            flag:0
                                   requestMethod:POST_METHOD
                            urlRequestSerializer:nil
                           urlResponseSerializer:nil];
}

+(instancetype)authNetworkingWithUrlString:(NSString *)urlString
                                  delegate:(id<TBBaseNetworkProrocol>)delegate
{
    TBBaseNetwork *network =  [[self class] networkingWithUrlString:urlString
                               requestDictionary:nil
                                        delegate:delegate
                                 timeoutInterval:nil
                                            flag:0
                                   requestMethod:POST_METHOD
                            urlRequestSerializer:nil
                           urlResponseSerializer:nil];
    RequestDictionarySerializer *serializer = [[TokenRequestSerializer alloc] init];
    network.requestDictionarySerializer = serializer;
    
    return network;
}

#pragma mark - 请求网络
-(void)startRequest
{
    if (self.urlString.length <= 0) {
        return;
    }
    
    _isRunning = YES;
    
    //请求类型
    if (self.requestSerializer) {
        self.manager.requestSerializer = self.requestSerializer;
    }else{
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    //响应类型
    if (self.responseSerializer) {
        self.manager.responseSerializer = self.responseSerializer;
    }else{
        self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    //设置请求头
    if (self.HTTPHeaderFieldsWithValues) {
        NSArray *allKeys = self.HTTPHeaderFieldsWithValues.allKeys;
        for (NSString *headerField in allKeys) {
            NSString *value = [self.HTTPHeaderFieldsWithValues valueForKey:headerField];
            [self.manager.requestSerializer setValue:value forKey:headerField];
        }
    }
    //设置超时时间
    if (self.timeoutInterval && self.timeoutInterval.floatValue > 0) {
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = self.timeoutInterval.floatValue;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    
    //设置请求参数转换器
    if (self.requestDictionarySerializer == nil) {
        self.requestDictionarySerializer = [[RequestDictionarySerializer alloc] init];
    }
    //设置响应参数转换器
    if (self.responseDataSerializer == nil) {
        self.responseDataSerializer = [[ResponseDataSerializer alloc] init];
    }
    
    __weak TBBaseNetwork *weakSelf = self;
    //处理入参 block内部中引用外部变量
    __block NSDictionary *requestDict = [self.requestDictionarySerializer transformRequestDictionaryWithInputDictionary:self.requestDictionary];
    //检查token
    if (requestDict == nil) {
        DEBUG_NSLOG(@"================ token auth failure =======");
        TBResponse *response = [[TBResponse alloc] initWithResponseStatus:TBURLSuccessCodeAuthFailure
                                                                operation:nil
                                                                     flag:0
                                                             responseData:nil];
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:)]) {
            [weakSelf.delegate requestFailed:response];
        }
        return;
    }
    
    //读取缓存
    if (self.shouldCache) {
        NSData * cacheResponseObject = [[TBCacheTool sharedInstance] fetchCacheDataWithUrl:self.urlString requestParams:requestDict];
        if (cacheResponseObject != nil) {
            DEBUG_NSLOG(@"\n\nurl:%@\n\n>>>>>>>>>>>>>>>>>>>>>           cache data:\n%@\n\n<<<<<<<<<<<<<<<<<<<<<<\n\n",weakSelf.urlString,[StringUtils stringFromData:cacheResponseObject]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                id responseData = [weakSelf.responseDataSerializer transformResponseDataWithInputData:cacheResponseObject];
                TBURLSuccessCode successCode = [responseData[@"code"] integerValue];
                TBResponse *successResponse = [[TBResponse alloc] initWithResponseStatus:successCode
                                                                               operation:weakSelf.httpOperation
                                                                                    flag:weakSelf.flag
                                                                            responseData:responseData];
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSuccess:)]) {
                    [weakSelf.delegate requestSuccess:successResponse];
                }
            });
            return;
        }
    }

    
    
    if (self.requestMethod == GET_METHOD) {
        DEBUG_NSLOG(@"\n\n====================    network Request   start\n\nurl : %@\nGET Params: \n\n====================    network Request   end\n\n",self.urlString);
        
        self.httpOperation = [self.manager GET:self.urlString
                                    parameters:requestDict
                                       success:^(AFHTTPRequestOperation * operation, id responseObject) {
                                           DEBUG_NSLOG(@"\n\nurl:%@\n\n>>>>>>>>>>>>>>>>>>>>>           response data:\n%@\n\n<<<<<<<<<<<<<<<<<<<<<<\n\n",weakSelf.urlString,responseObject);
                                           weakSelf.isRunning = NO;
                                           id responseData = [weakSelf.responseDataSerializer transformResponseDataWithInputData:responseObject];
                                           TBURLSuccessCode successCode = [responseData[@"code"] integerValue];
                                           //缓存
                                           if (self.shouldCache && successCode == TBURLSuccessCodeSuccess) {
                                               [[TBCacheTool sharedInstance] saveCacheWithData:responseObject url:weakSelf.urlString requestParams:requestDict];
                                           }
                                           TBResponse *successResponse = [[TBResponse alloc] initWithResponseStatus:successCode
                                                                                                          operation:weakSelf.httpOperation
                                                                                                               flag:weakSelf.flag
                                                                                                       responseData:responseData];
                                           if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSuccess:)]) {
                                               [weakSelf.delegate requestSuccess:successResponse];
                                           }
                                       }
                                       failure:^(AFHTTPRequestOperation * operation, NSError * error) {
                                           weakSelf.isRunning = NO;
                                           if (weakSelf.cancelType == USER_CANCEL) {
                                               DEBUG_NSLOG(@" =========================\n %@ \n=========================", @"Request Cancel");
                                               TBResponse *cancelResponse = [[TBResponse alloc] initWithResponseStatus:TBURLSuccessCodeNoNetwork
                                                                                                           operation:weakSelf.httpOperation
                                                                                                                flag:weakSelf.flag
                                                                                                        responseData:nil];
                                               if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestCancel:)]) {
                                                   [weakSelf.delegate requestCancel:cancelResponse];
                                               }
                                           }else{
                                               DEBUG_NSLOG(@" =========================\n %@ \n=========================",error);
                                               TBResponse *failResponse = [[TBResponse alloc] initWithResponseStatus:TBURLSuccessCodeNoNetwork
                                                                                                             operation:weakSelf.httpOperation
                                                                                                                  flag:weakSelf.flag
                                                                                                          responseData:nil];
                                               if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:)]) {
                                                   [weakSelf.delegate requestFailed:failResponse];
                                               }
                                           }
                                           
                                       }];
    }else if(self.requestMethod == POST_METHOD){
        DEBUG_NSLOG(@"\n\n====================    network Request   start\n\nurl : %@\nPOST Params: \n%@\n\n====================    network Request   end\n\n",self.urlString,[requestDict JSONString]);
        
        self.httpOperation = [self.manager POST:self.urlString
                                     parameters:requestDict
                                        success:^(AFHTTPRequestOperation * operation, id responseObject) {
                                            weakSelf.isRunning = NO;
                                            DEBUG_NSLOG(@"\n\nurl:%@\n\n>>>>>>>>>>>>>>>>>>>>>           response data:\n%@\n\n<<<<<<<<<<<<<<<<<<<<<<\n\n",weakSelf.urlString,operation.responseString);
                                            
                                            //防止服务器返回的数据为空
                                            if ([operation.responseString isEmptyString]) {
                                                TBResponse *failResponse = [[TBResponse alloc] initWithResponseStatus:TBURLSuccessCodeNoNetwork
                                                                                                            operation:weakSelf.httpOperation
                                                                                                                 flag:weakSelf.flag
                                                                                                         responseData:nil];
                                                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:)]) {
                                                    [weakSelf.delegate requestFailed:failResponse];
                                                }
                                                return ;
                                            }
                                            id responseData = [self.responseDataSerializer transformResponseDataWithInputData:responseObject];
                                            TBURLSuccessCode successCode = TBURLSuccessCodeNoData;
                                            if (responseData && [responseData objectForKey:@"code"]) {
                                                successCode = [responseData[@"code"] integerValue];
                                            }
                                            //请求成功，Code＝200 才缓存
                                            if (self.shouldCache && successCode == TBURLSuccessCodeSuccess) {
                                                [[TBCacheTool sharedInstance] saveCacheWithData:responseObject url:weakSelf.urlString requestParams:requestDict];
                                            }
                                            
                                            TBResponse *successResponse = [[TBResponse alloc] initWithResponseStatus:successCode
                                                                                                           operation:weakSelf.httpOperation
                                                                                                                flag:weakSelf.flag
                                                                                                        responseData:responseData];
                                            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestSuccess:)]) {
                                                [weakSelf.delegate requestSuccess:successResponse];
                                            }
                                        }
                                        failure:^(AFHTTPRequestOperation * operation, NSError * error) {

                                            weakSelf.isRunning = NO;
                                            if (weakSelf.cancelType == USER_CANCEL) {
                                                DEBUG_NSLOG(@" =========================\n %@ \n=========================" , @"Request Cancel");
                                                TBResponse *cancelResponse = [[TBResponse alloc] initWithResponseStatus:TBURLSuccessCodeNoNetwork
                                                                                                              operation:weakSelf.httpOperation
                                                                                                                   flag:weakSelf.flag
                                                                                                           responseData:nil];
                                                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestCancel:)]) {
                                                    [weakSelf.delegate requestCancel:cancelResponse];
                                                }
                                            }else{
                                                DEBUG_NSLOG(@" =========================\n %@ \n=========================" , error);
                                                TBResponse *failResponse = [[TBResponse alloc] initWithResponseStatus:TBURLSuccessCodeNoNetwork
                                                                                                            operation:weakSelf.httpOperation
                                                                                                                 flag:weakSelf.flag
                                                                                                         responseData:nil];
                                                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(requestFailed:)]) {
                                                    [weakSelf.delegate requestFailed:failResponse];
                                                }
                                            }
                                        }];
        
    }
}

-(void)cancelRequest
{
    self.cancelType = USER_CANCEL;
    [self.httpOperation cancel];
}

-(void)dealloc
{
    self.cancelType = DEALLOC_CANCEL;
    [self.httpOperation cancel];
    
    DEBUG_NSLOG(@"dealloc : ------%@------",self.urlString);
}

#pragma mark - block
+(AFHTTPRequestOperation *)POST:(NSString *)URLString
                     parameters:(id)parameters
                timeoutInterval:(NSNumber *)timeoutIntervall
                    urlRequestSerializer:(id<AFURLRequestSerialization>)requestSerializer
                   urlResponseSerializer:(id<AFURLResponseSerialization>)responseSerializer
                        success:(void (^)(AFHTTPRequestOperation *, id))success
                        failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    AFHTTPRequestOperationManager *manager            = [AFHTTPRequestOperationManager manager];
    // 设置请求类型
    manager.requestSerializer                         = requestSerializer;
    // 设置回复类型
    manager.responseSerializer                        = responseSerializer;
    //请求类型
    if (!manager.requestSerializer) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    //响应类型
    if (!manager.responseSerializer) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    // 设置回复内容信息
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    // 设置超时时间
    if (timeoutIntervall) {
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = timeoutIntervall.floatValue;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    
    
    AFHTTPRequestOperation *httpOperation = [manager POST:URLString
                                               parameters:parameters
                                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                      if (success) {
                                                          success(operation, responseObject);
                                                      }
                                                  }
                                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                      if (failure) {
                                                          failure(operation, error);
                                                      }
                                                  }];
    
    
    return httpOperation;
}

@end
