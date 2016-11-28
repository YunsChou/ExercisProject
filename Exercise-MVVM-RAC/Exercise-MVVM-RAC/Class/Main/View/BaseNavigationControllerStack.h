//
//  BaseNavigationControllerStack.h
//  Exercise-MVVM-RAC
//
//  Created by Yuns on 2016/11/27.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewModelServices;

@interface BaseNavigationControllerStack : NSObject


- (instancetype)initWithServices:(id<BaseViewModelServices>)services;

- (void)pushNavigationController:(UINavigationController *)navigationController;

- (UINavigationController *)popNavigationController;

- (UINavigationController *)topNavigationController;

@end
