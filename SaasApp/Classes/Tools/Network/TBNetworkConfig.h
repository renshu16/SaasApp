//
//  TBNetworkConfig.h
//  SaasApp
//
//  Created by ToothBond on 15/10/30.
//  Copyright © 2015年 ToothBond. All rights reserved.
//
#import <Availability.h>

#ifndef TBNetworkConfig_h
#define TBNetworkConfig_h

typedef NS_ENUM (NSInteger, TBURLResponseStatus)
{
    TBURLResponseStatusSuccess,
    TBURLResponseStatusErrorTimeout,
    TBURLResponseStatusErrorNoNetwork
}

static NSTimeInterval kTBNetworkTimeoutSeconds = 30.0f;


#endif /* TBNetworkConfig_h */
