//
//  TBResponse.m
//  SaasApp
//
//  Created by ToothBond on 15/11/10.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TBResponse.h"

@implementation TBResponse

-(instancetype)initWithResponseStatus:(TBURLSuccessCode)status operation:(AFHTTPRequestOperation *)operation flag:(NSInteger)flag responseData:(id)responseData
{
    self = [super init];
    if (self) {
        _status = status;
        _operation = operation;
        _flag = flag;
        _responseData = responseData;
    }
    return self;
}


-(instancetype)initWithOperation:(AFHTTPRequestOperation *)operation flag:(NSInteger)flag responseData:(id)responseData error:(NSError *)error
{
    self = [super init];
    if (self) {
        _status = TBURLSuccessCodeNoNetwork;
        _operation = operation;
        _flag = flag;
        _responseData = responseData;
    }
    return self;
}

//-(TBURLResponseStatus)responseStatusWithError:(NSError *)error
//{
//    if (error) {
//        TBURLResponseStatus status = TBURLResponseStatusErrorNoNetwork;
//        
//        // 除了超时以外，所有错误都当成是无网络
//        if (error.code == NSURLErrorTimedOut) {
//            status = TBURLResponseStatusErrorNoNetwork;
//        }
//        return status;
//    } else {
//        return TBURLResponseStatusSuccess;
//    }
//}

@end
