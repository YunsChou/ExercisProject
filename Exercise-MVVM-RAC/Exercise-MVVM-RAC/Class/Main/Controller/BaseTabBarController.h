//
//  BaseTabBarController.h
//  Exercise-MVVM-RAC
//
//  Created by Yuns on 2016/11/28.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTabBarController : BaseViewController <UITabBarControllerDelegate>

@property (nonatomic, strong, readonly) UITabBarController *tabBarController;

@end
