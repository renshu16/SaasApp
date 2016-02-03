//
//  TBBaseController.m
//  SaasApp
//
//  Created by ToothBond on 15/11/9.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "TBBaseController.h"
#import "TBLoadingView.h"
#import "MainController.h"

@interface TBBaseController ()

@property(nonatomic,strong)TBLoadingView *loadingView;
@property(nonatomic,strong)UILabel *noDataView;

@end

@implementation TBBaseController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = color_bg_window;

    //设置标题样式
    UINavigationBar *bar = [self.navigationController navigationBar];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : color_font_title,
                                  NSFontAttributeName : font_main_title}];
    
//    if([self isKindOfClass:[ScheduleController class]] ||
//       [self isKindOfClass:[BespeakController class]] ||
//       [self isKindOfClass:[MineController class]]
//       ){
//        
//    }
//    //隐藏back按键
//    else if([self isKindOfClass:[BelongHosListController class]]){
//        self.navigationItem.hidesBackButton = YES;
//    }
//    else{
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *backBtnImage = [UIImage imageNamed:@"nav_back"];
//        [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
//        [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//        backBtn.frame = CGRectMake(0, 0, backBtnImage.size.width, backBtnImage.size.height);
//        [backBtn setHighlighted:NO];
//        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//        backButton.style =  UIBarButtonItemStylePlain;
//        
//        self.navigationItem.leftBarButtonItem = backButton;
//    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if([self isKindOfClass:[ScheduleController class]] ||
//       [self isKindOfClass:[BespeakController class]] ||
//       [self isKindOfClass:[MineController class]]
//       ){
//        [self.tabBarController.tabBar setHidden:NO];
//    }
//    else
//        [self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - private Method
-(void)initRightKey:(id)object
{
    if(object != nil)
    {
        if([object isKindOfClass:[NSString class]])
        {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *title = (NSString *)object;
            [rightBtn setTitle:title forState:UIControlStateNormal];
            [rightBtn setShowsTouchWhenHighlighted:YES];
            [rightBtn setTitleColor:color_btn_blue forState:UIControlStateNormal];
            [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
            rightBtn.frame = CGRectMake(0, 0, 40, 20);
            UIBarButtonItem *rightItemBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn] ;
            self.navigationItem.rightBarButtonItem = rightItemBtn;
        }
        else if([object isKindOfClass:[UIImage class]])
        {
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *image = (UIImage *)object;
            [rightBtn setImage:image forState:UIControlStateNormal];
            rightBtn.titleLabel.text = @"";
            [rightBtn setShowsTouchWhenHighlighted:YES];
            [rightBtn addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
            rightBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
            UIBarButtonItem *rightItemBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn] ;
            self.navigationItem.rightBarButtonItem = rightItemBtn;
        }
        else if([object isKindOfClass:[UIView class]])
        {
            if([object isKindOfClass:[UIButton class]]){
                //强改btn字体颜色
                UIButton * btn = (UIButton*)object;
                [btn setTitleColor:color_btn_blue forState:UIControlStateNormal];
            }
            UIView *rightBtn = (UIView *)object;
            
            UIBarButtonItem *rightItemBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBtn] ;
            self.navigationItem.rightBarButtonItem = rightItemBtn;
        }
    }
    
}

-(BOOL)isRootController
{
    BOOL result = NO;
    if(self.navigationController != nil && self.navigationController.viewControllers.count > 0)
    {
        if([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self])
            result = YES;
    }
    return result;
}
-(BOOL)isTopController
{
    BOOL result = NO;
    if(self.navigationController != nil && self.navigationController.viewControllers.count > 0)
    {
        if([[self.navigationController topViewController] isEqual:self])
            result = YES;
    }
    return result;
}

#pragma mark - event response
-(void)backAction:(UIButton *)btn
{
    if(self.navigationController != nil){
        if([self isRootController])
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        else
            [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)rightAction:(UIButton *)btn
{
    
}


#pragma mark - getter setter
-(TBLoadingView *)loadingView
{
    if (_loadingView == nil) {
        _loadingView = [[TBLoadingView alloc] initWithFrame:self.view.bounds];
    }
    return _loadingView;
}
-(UILabel *)noDataView
{
    if (_noDataView == nil) {
        _noDataView = [[UILabel alloc] initWithFrame:self.view.bounds];
        _noDataView.backgroundColor = color_bg_window;
        _noDataView.font = font_content;
        _noDataView.textColor = color_font_text_black;
        _noDataView.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_noDataView];
    }
    return _noDataView;
}

#pragma mark - public Method
-(void)initNavigationWithRightKey:(id)object isShowRight:(BOOL)isShow
{
    self.navigationController.navigationBarHidden = NO;
    if (isShow) {
        [self initRightKey:object];
    }
}

-(void)showLoading
{
    if ([self.loadingView isLoading]) return;
    [self.loadingView removeFromSuperview];
    [self.view addSubview:self.loadingView];
    [self.loadingView showLoading];
    [self.view bringSubviewToFront:self.loadingView];
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
    [self.view bringSubviewToFront:self.noDataView];
}
-(void)hiddenNoDataView
{
    self.noDataView.hidden = YES;
    [self.view sendSubviewToBack:self.noDataView];
}

//获取当前屏幕显示的viewcontroller
+(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;//当前根UINavigationController
    
    //获取NavigationController栈顶的ViewController
    UIViewController *topVC = nil;
    if ([result isKindOfClass:[MainController class]]) {
        MainController * tabbar = (MainController*)result;
        UINavigationController *rootNav = (UINavigationController *)tabbar.selectedViewController;
        NSArray *viewControllers = rootNav.viewControllers;
        topVC = [viewControllers lastObject];
        
    }
    return topVC;
    
}

@end
