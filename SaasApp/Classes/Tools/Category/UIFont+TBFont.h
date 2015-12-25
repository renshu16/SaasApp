//
//  UIFont+TBFont.h
//  SaasApp
//
//  Created by ToothBond on 15/11/7.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (TBFont)
/**
 *  修改一般文本字体
 */
+(UIFont*)tbFontOfSize:(CGFloat)fontSize;

/**
 *  修改符号文字字体
 */
+(UIFont *)tbSymbolFontOfSize:(CGFloat)fontSize;
@end
