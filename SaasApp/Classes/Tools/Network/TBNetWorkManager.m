//
//  TBNetWorkManager.m
//  SaasApp
//
//  Created by ToothBond on 15/10/30.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TBNetWorkManager.h"
#import <AFNetworking/AFNetworking.h>

@interface TBNetWorkManager ()
@property (nonatomic, strong) NSMutableDictionary *dispatchTable;
@property (nonatomic, strong) NSNumber *recordedRequestID;

@property (nonatomic, strong) AFHTTPSessionManager *sesstionManager;
@end

@implementation TBNetWorkManager

-(NSMutableDictionary *)dispatchTable
{
    if (_dispatchTable == nil) {
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    return _dispatchTable;
}

-(AFHTTPSessionManager *)sesstionManager
{
    if (_sesstionManager == nil) {
        _sesstionManager = 
    }
}

@end
