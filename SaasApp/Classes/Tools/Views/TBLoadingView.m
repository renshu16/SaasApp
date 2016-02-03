//
//  TBLoadingView.m
//  SaasApp
//
//  Created by ToothBond on 15/11/21.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TBLoadingView.h"

@implementation TBLoadingView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initControls];
    }
    return self;
}

-(void)initControls
{
    self.backgroundColor = color_btn_highlight_gray;
    [self addSubview:self.indicatorView];
    self.indicatorView.center = CGPointMake(self.center.x, self.center.y * 0.8);
}

-(UIActivityIndicatorView *)indicatorView
{
    if (_indicatorView == nil) {
        _indicatorView = [[UIActivityIndicatorView alloc] init];
    }
    return _indicatorView;
}


#pragma mark - public
-(void)showLoading
{
    if (self.indicatorView.isAnimating) return;
    [self.indicatorView startAnimating];
}
-(void)dismissLoading
{
    [self.indicatorView stopAnimating];
}
-(BOOL)isLoading
{
    return [self.indicatorView isAnimating];
}

@end
