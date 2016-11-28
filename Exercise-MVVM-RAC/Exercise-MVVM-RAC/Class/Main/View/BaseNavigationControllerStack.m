//
//  BaseNavigationControllerStack.m
//  Exercise-MVVM-RAC
//
//  Created by Yuns on 2016/11/27.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseNavigationControllerStack.h"

@interface BaseNavigationControllerStack ()
@property (nonatomic, strong) id<BaseViewModelServices> services;
@property (nonatomic, strong) NSMutableArray *navigationControllers;
@end

@implementation BaseNavigationControllerStack

- (instancetype)initWithServices:(id<BaseViewModelServices>)services
{
    self = [super init];
    if (self) {
        self.services = services;
        self.navigationControllers = [NSMutableArray array];
        
    }
    return self;
}

//- (void)pushNavigationController:(UINavigationController *)navigationController
//{
//
//}
//
//- (UINavigationController *)popNavigationController
//{
//
//}
//
//- (UINavigationController *)topNavigationController
//{
//
//}

@end
