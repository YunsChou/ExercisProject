//
//  BaseTabBarController.m
//  Exercise-MVVM-RAC
//
//  Created by Yuns on 2016/11/28.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()
@property (nonatomic, strong, readwrite) UITabBarController *tabBarController;
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController = [[UITabBarController alloc] init];
    
    [self addChildViewController:self.tabBarController];
    [self.view addSubview:self.tabBarController.view];
}

- (BOOL)shouldAutorotate
{
    return self.tabBarController.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.tabBarController.selectedViewController.supportedInterfaceOrientations;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.tabBarController.selectedViewController.preferredStatusBarStyle;
}

@end
