//
//  TBBaseNetwork.h
//  SaasApp
//
//  Created by ToothBond on 15/11/4.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "RequestDictionarySerializer.h"
#import "TokenRequestSerializer.h"
#import "ResponseDataSerializer.h"
#import "TBResponse.h"

/**
 *  提供给外部监听用,监测网络状态变化
 */
static NSString *NetworkingReachability        = @"_networkingReachability_";

/**
 *  外部接收通知用字符串
 */
static NSString *NetworkingStatus_WWAN         = @"_netStatus_WWAN_";
static NSString *NetworkingStatus_WIFI         = @"_netStatus_WIFI_";
static NSString *NetworkingStatus_NotReachable = @"_netStatus_NotReachable_";

typedef enum : NSUInteger {
    GET_METHOD,     //GET请求
    POST_METHOD,    //POST请求
    UPLOAD_DATA,    //上传文件的请求（POST）
}AFNetworkRequestMethod;

////请求格式
//typedef enum : NSUInteger {
//    HTTPRequestType = 0x11,     // 二进制格式 (不设置的话为默认格式)
//    JSONRequestType,            // JSON方式
//    PlistRequestType,           //集合文件方式
//} AFNetworkingRequestType;
//
////服务器响应格式
//typedef enum : NSUInteger {
//    /*------ 常用 ------*/
//    HTTPResponseType = 0x33,     // 二进制格式 (不设置的话为默认格式)
//    JSONResponseType,            // JSON方式
//    XMLType,                     // XML的方式
//    ImageResponseType,           // 图片方式
//    /*-----------------*/
//    
//    PlistResponseType,           // 集合文件方式
//    CompoundResponseType,        // 组合方式
//} AFNetworkingResponseType;

@protocol TBBaseNetworkProrocol <NSObject>

@optional

/**
 *  请求成功
 */
-(void)requestSuccess:(TBResponse *)response;

/**
 *  请求失败
 */
-(void)requestFailed:(TBResponse *)response;

/**
 *  用户取消请求
 */
-(void)requestCancel:(TBResponse *)response;

@end

@interface TBBaseNetwork : NSObject

+(void)showNetworkActivityIndicator:(BOOL)isShow;

+(void)startMonitoring;

+(void)stopMonitoring;

+(BOOL)isReachable;

+(BOOL)isReachableViaWWAN;

+(BOOL)isReachableViaWIFI;

@property (nonatomic,weak    ) id<TBBaseNetworkProrocol> delegate;

@property (nonatomic         ) NSInteger              flag;
@property (nonatomic,strong  ) NSNumber               *timeoutInterval;
@property (nonatomic         ) AFNetworkRequestMethod requestMethod;
@property (nonatomic,strong  ) NSString               *urlString;
@property (nonatomic,strong  ) NSDictionary           *requestDictionary;
@property (nonatomic,strong  ) NSDictionary           *HTTPHeaderFieldsWithValues;
@property (nonatomic         ) BOOL                   isRunning;
@property (nonatomic         ) BOOL                   shouldCache;

@property (nonatomic, strong, readwrite) id <AFURLRequestSerialization>  requestSerializer;
@property (nonatomic, strong, readwrite) id <AFURLResponseSerialization> responseSerializer;

@property(nonatomic,strong)id <RequestDictionarySerialication>  requestDictionarySerializer;
@property(nonatomic,strong)id <ResponseDataSerialization>       responseDataSerializer;

-(void)startRequest;

-(void)cancelRequest;

#pragma mark - 构造方法
/**
 *  请求实例构造方法
 *
 *  @param urlString          urlString
 *  @param requestDictionary  请求参数
 *  @param delegate           代理
 *  @param timeoutInterval    超时时间，设置nil 默认为30s
 *  @param flag               flag
 *  @param requestMethod      请求方式 GET_METHOD  POST_METHOD
 *  @param requestSerializer  AFHTTPRequestSerializer AFJSONRequestSerializer AFPropertyListRequestSerializer
 *  @param responseSerializer AFHTTPResponseSerializer AFJSONResponseSerializer AFXMLParserResponseSerializer AFXMLDocumentResponseSerializer AFPropertyListResponseSerializer AFImageResponseSerializer AFCompoundResponseSerializer
 *
 *  @return 请求实例对象
 */
+(instancetype)networkingWithUrlString:(NSString *)urlString
                     requestDictionary:(NSDictionary *)requestDictionary
                              delegate:(id<TBBaseNetworkProrocol>)delegate
                       timeoutInterval:(NSNumber *)timeoutInterval
                                  flag:(NSInteger)flag
                         requestMethod:(AFNetworkRequestMethod)requestMethod
                  urlRequestSerializer:(id<AFURLRequestSerialization>)requestSerializer
                 urlResponseSerializer:(id<AFURLResponseSerialization>)responseSerializer;

/**
 *  便利构造器，不需要验证token
 *
 *  @param urlString         urlString
 *  @param requestDictionary requestDictionary description
 *  @param delegate          代理
 *
 *  @return 请求实例对象
 */
+(instancetype)networkingWithUrlString:(NSString *)urlString
                     requestDictionary:(NSDictionary *)requestDictionary
                              delegate:(id<TBBaseNetworkProrocol>)delegate;

/**
 *  便利构造器，需要验证token,必须先登录
 *
 *  @param urlString urlString
 *  @param delegate  代理
 *
 *  @return 请求实例对象
 */
+(instancetype)authNetworkingWithUrlString:(NSString *)urlString
                              delegate:(id<TBBaseNetworkProrocol>)delegate;

#pragma mark - block形式请求
+(AFHTTPRequestOperation *)POST:(NSString *)URLString
                     parameters:(id)parameters
                timeoutInterval:(NSNumber *)timeoutIntervall
           urlRequestSerializer:(id<AFURLRequestSerialization>)requestSerializer
          urlResponseSerializer:(id<AFURLResponseSerialization>)responseSerializer
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void(^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
