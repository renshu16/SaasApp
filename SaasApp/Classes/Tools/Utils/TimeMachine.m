//
//  TimeMachine.m
//  SaasApp
//
//  Created by ToothBond on 15/11/12.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TimeMachine.h"

/**
 *  倒计时
 */
@interface TimeMachine ()

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation TimeMachine

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static TimeMachine *sharedInstance = nil;
    dispatch_once(&onceToken,^{
        sharedInstance = [[TimeMachine alloc] init];
    });
    return sharedInstance;
}

- (void)startTimerDown:(NSUInteger)timeCount delegate:(id<TimeMachineDelegate>)delegate
{
    if (self.timeCount > 0) {
        return;
    }
    self.delegate = delegate;
    self.timeCount = timeCount;
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timesUpdate) userInfo:nil repeats:YES];
    }else{
        [_timer invalidate];
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timesUpdate) userInfo:nil repeats:YES];
    }
    
}

-(void)timesUpdate
{
    self.timeCount --;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onTimeUpdate:)]) {
        [self.delegate onTimeUpdate:self.timeCount];
    }
    if(self.timeCount == 0){
        [self.timer invalidate];
    }
}

//-(NSInteger)timeCount
//{
//    return self.timeCount;
//}

@end
