//
//  TBNetWorkManager.h
//  SaasApp
//
//  Created by ToothBond on 15/10/30.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "TBURLResponse.h"

typedef void (^TBNetWorkCallBack)(TBURLResponse *response);

@interface TBNetWorkManager : AFHTTPSessionManager

+ (instancetype)sharedInstance;


-(NSInteger)HTTPGETWithParams:(NSString *)params apiName:(NSString *)apiName success:(TBNetWorkCallBack)success fail:(TBNetWorkCallBack)fail;

-(NSInteger)HTTPPOSTWithParams:(NSString *)params apiName:(NSString *)apiName success:(TBNetWorkCallBack)success fail:(TBNetWorkCallBack)fail;

-(void)cancelRequestWithRequestID:(NSNumber *)requestID;
-(void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;
@end
