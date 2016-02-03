//
//  TBBaseController.h
//  SaasApp
//
//  Created by ToothBond on 15/11/9.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CommonString.h"
#import "CommonUI.h"
#import "Masonry.h"
#import "StringUtils.h"

#import "UIFont+TBFont.h"
#import "UIImage+TBColor.h"
#import "UIView+TBView.h"
#import "NSString+TBString.h"
#import "UIKit+AFNetworking.h"
//#import <SDWebImage/UIImageView+WebCache.h>

#define  ShowMessage(msg)   [(AppDelegate *)[[UIApplication sharedApplication] delegate] showMsg:(msg) hiddenTime:1.5f];

@interface TBBaseController : UIViewController

-(void)initNavigationWithRightKey:(id)object isShowRight:(BOOL)isShow;

-(void)backAction:(UIButton *)btn;
-(void)rightAction:(UIButton *)btn;

-(void)showLoading;
-(void)dismissLoading;

-(void)showNoDataView;
-(void)showNoDataViewWithTips:(NSString *)tips;
-(void)hiddenNoDataView;

+(UIViewController *)getCurrentVC;

@end
