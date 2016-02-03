//
//  ThirdController.m
//  SaasApp
//
//  Created by ToothBond on 16/2/3.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

#import "ThirdController.h"

@interface ThirdController ()

@end

@implementation ThirdController

-(id)init
{
    if (self = [super init]) {
        [self setupTabBarStyle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupTabBarStyle
{
    self.title = NSStringFromClass([self class]);
    //    self.tabBarItem.image = [UIImage imageNamed:@"tab_sch"];
    //    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_sch_selected"];
}


@end
