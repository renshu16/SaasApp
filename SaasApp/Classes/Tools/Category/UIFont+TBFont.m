//
//  UIFont+TBFont.m
//  SaasApp
//
//  Created by ToothBond on 15/11/7.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "UIFont+TBFont.h"

@implementation UIFont (TBFont)

+(UIFont*)tbFontOfSize:(CGFloat)fontSize
{
    //    return [UIFont systemFontOfSize:fontSize];
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    //    return [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];//中文有bug  //HYQiHei-EZJ //AppleGothic
}

+(UIFont *)tbSymbolFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"EuphemiaUCAS" size:fontSize];
}

@end
