//
//  BaseRouter.m
//  Exercise-MVVM-RAC
//
//  Created by Yuns on 2016/11/27.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseRouter.h"

@interface BaseRouter ()
@property (nonatomic, strong) NSDictionary *viewModelViewMappings;
@end

@implementation BaseRouter

+ (instancetype)sharedInstance
{
    static BaseRouter *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (BaseViewController *)viewControllerForViewModel:(BaseViewModel *)viewModel
{
    NSString *viewControllerName = self.viewModelViewMappings[NSStringFromClass(viewModel.class)];
    NSParameterAssert([NSClassFromString(viewControllerName) isSubclassOfClass:[BaseViewController class]]);
    NSParameterAssert([NSClassFromString(viewControllerName) instancesRespondToSelector:@selector(initWithViewModel:)]);
    
    return [[NSClassFromString(viewControllerName) alloc] initWithViewModel:viewModel];
}

- (NSDictionary *)viewModelViewMappings
{
    return @{
             @"LoginViewModel" : @"LoginViewController",
             @"HomePageViewModel" : @"HomepageViewController"
             };
}

@end
