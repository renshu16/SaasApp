//
//  ResponseDataSerializer.h
//  SaasApp
//
//  Created by ToothBond on 15/11/6.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResponseDataSerialization <NSObject>

@required
-(id)transformResponseDataWithInputData:(id)data;

@end

@interface ResponseDataSerializer : NSObject<ResponseDataSerialization>

@end
