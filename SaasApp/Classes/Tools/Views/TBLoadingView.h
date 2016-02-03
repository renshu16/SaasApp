//
//  TBLoadingView.h
//  SaasApp
//
//  Created by ToothBond on 15/11/21.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBLoadingView : UIView

@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;

-(void)showLoading;
-(void)dismissLoading;
-(BOOL)isLoading;

@end
