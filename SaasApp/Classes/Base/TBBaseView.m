//
//  TBBaseView.m
//  SaasApp
//
//  Created by ToothBond on 15/12/4.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TBBaseView.h"
#import "TBLoadingView.h"

@interface TBBaseView()

@property(nonatomic,strong)TBLoadingView *loadingView;
@property(nonatomic,strong)UILabel *noDataView;

@end

@implementation TBBaseView

-(void)showLoading
{
    if ([self.loadingView isLoading]) return;
    [self.loadingView removeFromSuperview];
    [self addSubview:self.loadingView];
    [self.loadingView showLoading];
    [self bringSubviewToFront:self.loadingView];
}
-(void)dismissLoading
{
    [self.loadingView dismissLoading];
    [self.loadingView removeFromSuperview];
}

-(void)showNoDataView
{
    [self showNoDataViewWithTips:tips_no_data];
}

-(void)showNoDataViewWithTips:(NSString *)tips
{
    self.noDataView.text = tips;
    self.noDataView.hidden = NO;
    //[self bringSubviewToFront:self.noDataView];
}
-(void)hiddenNoDataView
{
    self.noDataView.hidden = YES;
    //[self sendSubviewToBack:self.noDataView];
}

#pragma mark - getter setter
-(TBLoadingView *)loadingView
{
    if (_loadingView == nil) {
        _loadingView = [[TBLoadingView alloc] initWithFrame:self.bounds];
    }
    return _loadingView;
}
-(UILabel *)noDataView
{
    if (_noDataView == nil) {
        _noDataView = [[UILabel alloc] initWithFrame:self.bounds];
        _noDataView.backgroundColor = color_bg_window;
        _noDataView.font = [UIFont systemFontOfSize:16];
        _noDataView.textColor = color_font_text_black;
        _noDataView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_noDataView];
    }
    return _noDataView;
}

@end
