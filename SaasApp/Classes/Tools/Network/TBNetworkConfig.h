//
//  TBNetworkConfig.h
//  SaasApp
//
//  Created by ToothBond on 15/10/30.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#ifndef TBNetworkConfig_h
#define TBNetworkConfig_h

#endif /* TBNetworkConfig_h */

/**
 *  网络请求底层响应
 */
typedef NS_ENUM(NSInteger, TBURLResponseStatus) {
    /**
     *  请求成 功
     */
    TBURLResponseStatusSuccess = 1,
    /**
     *  用户取消
     */
    TBURLResponseStatusCancel = -4,
    /**
     *  认证失败
     */
    TBURLResponseStatusAuthFailure = -3,
    /**
     *  请求超时
     */
    TBURLResponseStatusErrorTimeout = -2,
    /**
     *  连接失败
     */
    TBURLResponseStatusErrorNoNetwork = -1,

};

/**
 *  接口返回码
 */
typedef NS_ENUM(NSInteger, TBURLSuccessCode) {
    /**
     *  请求成功
     */
    TBURLSuccessCodeSuccess = 200,
    /**
     *  暂无数据
     */
    TBURLSuccessCodeNoData = 203,
    /**
     *  token失效
     */
    TBURLSuccessCodeAuthFailure = 401,
    /**
     *  缺少参数
     */
    TBURLSuccessCodeParamsError = 412,
    /**
     *  服务器出错
     */
    TBURLSuccessCodeServerError = 500,
    /**
     *  无网络
     */
    TBURLSuccessCodeNoNetwork = -1,
};

#define API_VERSION  @"1"

static NSTimeInterval kTBNetworkTimeoutSeconds = 30.0f;// 请求超时30s

static NSTimeInterval kTBCacheTimeOutSeconds = 300;// 5分钟的cache过期时间
static NSUInteger     kTBCacheCountLimit = 1000; // 最多1000条cache

#ifdef DEBUG
    static NSString *TBBaseURL  = @"http://192.168.1.21:9001/aiyacloud/";
//    static NSString *TBBaseURL  = @"https://192.168.1.233:8443/";
#else
    static NSString *TBBaseURL  = @"http://www.51aiya.com/";
#endif

/**
 *  时间间隔参数类型
 */
typedef NS_ENUM(NSInteger, BespeakTimeIntervalType) {
    BespeakTimeIntervalTypeDay = 1,
    BespeakTimeIntervalTypeWeek = 2,
    BespeakTimeIntervalTypeMonth = 3,
    BespeakTimeIntervalTypeYear = 4,
    BespeakTimeIntervalTypeOther = 5,
};