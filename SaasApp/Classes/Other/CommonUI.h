//
//  CommonUI.h
//  SaasApp
//
//  Created by ToothBond on 15/11/7.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#ifndef CommonUI_h
#define CommonUI_h


#endif /* CommonUI_h */

#pragma mark - Font

#define MainTitleFontSize       18.0
#define TitleFontSize           16.0
#define SubTitleFontSize        14.0

#define MainContentFontSize     15.0
#define ContentFontSize         14.0
#define SubContentFontSize      12.0

#define font_main_title         [UIFont systemFontOfSize:MainTitleFontSize]
#define font_title              [UIFont systemFontOfSize:TitleFontSize]
#define font_sub_title          [UIFont systemFontOfSize:SubTitleFontSize]

#define font_main_content       [UIFont systemFontOfSize:MainContentFontSize]
#define font_content            [UIFont systemFontOfSize:ContentFontSize]
#define font_sub_content        [UIFont systemFontOfSize:SubContentFontSize]




#pragma mark - Color

#define RGBCOLOR(r,g,b)         [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define RGBACOLOR(r,g,b,a)      [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// HEXCOLOR(0xff7d05);
#define HEXCOLOR(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define color_random            [UIColor colorWithRed:(arc4random() % 256 / 255.0) green:(arc4random() % 256 / 255.0) blue:(arc4random() % 256 / 255.0) alpha:1.0f]

#define color_bg_window             HEXCOLOR(0xfbfbfb)
#define color_line_divide           HEXCOLOR(0xe2e2e2)
#define color_btn_blue              HEXCOLOR(0x5AA3EE)
#define color_btn_black             RGBCOLOR(86, 86, 86)
#define color_btn_white             RGBCOLOR(255, 255, 255)
#define color_btn_highlight_gray    RGBACOLOR(20, 20, 20, 0.3f)//按钮highlight 深灰色


#define color_font_title            RGBCOLOR(0, 0, 0)
#define color_font_text_black       RGBCOLOR(86, 86, 86)
#define color_font_subtext_black    RGBCOLOR(128, 128, 128)
#define color_font_placeholder      RGBCOLOR(203, 203, 203)


#define color_theme_orange          RGBCOLOR(255, 172, 21)
#define color_theme_blue            HEXCOLOR(0x5AA3EE)



#pragma mark - frame

#define OBJRIGHT(obj)                   (obj.frame.origin.x + obj.frame.size.width)
#define OBJBOTTOM(obj)                  (obj.frame.origin.y + obj.frame.size.height)
#define OBJTOPALIGN(obj)                (CGRectGetMinY(obj.frame))
#define OBJBOTTOMALIGN(obj,selfHeight)  (CGRectGetMaxY(obj.frame) - selfHeight)


#define kPadding            5.0
#define kCornerRadius       3.0
#define screenWidth         [[UIScreen mainScreen] bounds].size.width
#define screenHeight        [[UIScreen mainScreen] bounds].size.height
#define kTabbarHeight        49


#define kUserIconRadius     40
#define kTextFeildHeight    60
#define kTextFeildWidth     (screenWidth * 0.8)
#define kBtnHeight          44

#pragma mark - schedule frame
#define FACE_IMAGE_RADIUS   30.0
#define FACE_LEFT_PADDING   18.0
#define SCH_TIME_LINE_HEAD_HEIGHT   100