//
//  SecondController.m
//  SaasApp
//
//  Created by ToothBond on 16/2/3.
//  Copyright © 2016年 ToothBond. All rights reserved.
//

#import "SecondController.h"

@interface SecondController ()

@end

@implementation SecondController

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
    self.view.backgroundColor = [UIColor blueColor];
}

-(void)setupTabBarStyle
{
    self.title = NSStringFromClass([self class]);
    //    self.tabBarItem.image = [UIImage imageNamed:@"tab_sch"];
    //    self.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_sch_selected"];
}

@end
