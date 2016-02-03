//
//  TBScrollView.h
//  SaasApp
//
//  Created by ToothBond on 15/11/16.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TBScrollViewDelegate <NSObject>
-(void)onTouch:(UIView*)view;
@end

@interface TBScrollView : UIScrollView

@property(nonatomic,weak)id<TBScrollViewDelegate> tbDelegate;

@end
