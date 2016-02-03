//
//  TBScrollView.m
//  SaasApp
//
//  Created by ToothBond on 15/11/16.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TBScrollView.h"

@implementation TBScrollView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if(self.tbDelegate != nil && [self.tbDelegate respondsToSelector:@selector(onTouch:)])
        [self.tbDelegate onTouch:self];
}

@end
