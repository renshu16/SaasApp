//
//  ViewController.m
//  SaasApp
//
//  Created by ToothBond on 15/10/27.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import "MainController.h"
#import "FirstController.h"
#import "SecondController.h"
#import "ThirdController.h"


@interface MainController ()

@property(nonatomic,strong)FirstController *firstController;
@property(nonatomic,strong)SecondController *secondController;
@property(nonatomic,strong)ThirdController *thirdController;

@end

@implementation MainController

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildControllers];
        self.tabBarController.tabBar.translucent = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)addChildControllers
{
    self.firstController = [[FirstController alloc] init];
    UINavigationController *firstNavigation = [[UINavigationController alloc] initWithRootViewController:self.firstController];
    firstNavigation.navigationBar.translucent = NO;
    self.secondController = [[SecondController alloc]init];
    UINavigationController *secondNavigation = [[UINavigationController alloc] initWithRootViewController:self.secondController];
    secondNavigation.navigationBar.translucent = NO;
    self.thirdController = [[ThirdController alloc] init];
    UINavigationController *thirdNavigation = [[UINavigationController alloc] initWithRootViewController:self.thirdController];
    thirdNavigation.navigationBar.translucent = NO;
    
    self.viewControllers = @[firstNavigation,secondNavigation,thirdNavigation];
}

@end
