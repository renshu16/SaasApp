//
//  UIView+TBView.m
//  SaasApp
//
//  Created by ToothBond on 15/11/20.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "UIView+TBView.h"

@implementation UIView (TBView)

+ (instancetype)getLineView
{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 0.5)];
    lineView.backgroundColor = color_line_divide;
    return lineView;
}

@end
