//
//  TBBaseView.h
//  SaasApp
//
//  Created by ToothBond on 15/12/4.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBBaseView : UIView

-(void)showLoading;
-(void)dismissLoading;

-(void)showNoDataView;
-(void)showNoDataViewWithTips:(NSString *)tips;
-(void)hiddenNoDataView;

@end
