//
//  TBResponse.h
//  SaasApp
//
//  Created by ToothBond on 15/11/10.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBNetworkConfig.h"
@class AFHTTPRequestOperation;

@interface TBResponse : NSObject

@property (nonatomic,strong,readonly) id                     responseData;
@property (nonatomic,assign,readonly) TBURLSuccessCode       status;
@property (nonatomic,strong,readonly) AFHTTPRequestOperation *operation;
@property (nonatomic,assign,readonly) NSInteger              flag;


-(instancetype)initWithResponseStatus:(TBURLSuccessCode)status operation:(AFHTTPRequestOperation *)operation flag:(NSInteger)flag responseData:(id)responseData;

-(instancetype)initWithOperation:(AFHTTPRequestOperation *)operation flag:(NSInteger)flag responseData:(id)responseData error:(NSError *)error;

@end
