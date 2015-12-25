//
//  TimeMachine.h
//  SaasApp
//
//  Created by ToothBond on 15/11/12.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TimeMachineDelegate <NSObject>

@optional
-(void)onTimeUpdate:(NSInteger)seconds;

@end

@interface TimeMachine : NSObject

+(instancetype)sharedInstance;

- (void)startTimerDown:(NSUInteger)timeCount delegate:(id<TimeMachineDelegate>)delegate;

-(NSInteger)timeCount;

@property(nonatomic,weak)id<TimeMachineDelegate> delegate;

@property(nonatomic,assign)NSInteger timeCount;

@end
