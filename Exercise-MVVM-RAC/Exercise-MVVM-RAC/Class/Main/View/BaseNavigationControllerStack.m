//
//  BaseNavigationControllerStack.m
//  Exercise-MVVM-RAC
//
//  Created by Yuns on 2016/11/27.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseNavigationControllerStack.h"
#import "BaseRouter.h"
#import "BaseNavigationController.h"
#import "BaseTabBarController.h"

@interface BaseNavigationControllerStack () <UINavigationControllerDelegate>
@property (nonatomic, strong) id<BaseViewModelServices> services;
@property (nonatomic, strong) NSMutableArray *navigationControllers;
@end

@implementation BaseNavigationControllerStack

- (instancetype)initWithServices:(id<BaseViewModelServices>)services
{
    self = [super init];
    if (self) {
        self.services = services;
        self.navigationControllers = [[NSMutableArray alloc] init];
        [self registerNavigatoinHooks];
    }
    return self;
}

- (void)pushNavigationController:(UINavigationController *)navigationController
{
    if ([self.navigationControllers containsObject:navigationController]) {
        return;
    }
    navigationController.delegate = self;
    [self.navigationControllers addObject:navigationController];
}

- (UINavigationController *)popNavigationController
{
    UINavigationController *navigationController = self.navigationControllers.lastObject;
    [self.navigationControllers removeLastObject];
    return navigationController;
}

- (UINavigationController *)topNavigationController
{
    return self.navigationControllers.lastObject;
}

- (void)registerNavigatoinHooks
{
    @weakify(self);

    [[(NSObject *)self.services rac_signalForSelector:@selector(resetRootViewModel:)] subscribeNext:^(RACTuple *tuple) {
        @strongify(self);
        [self.navigationControllers removeAllObjects];
        
        UIViewController *viewController = (UIViewController *)[BaseRouter.sharedInstance viewControllerForViewModel:tuple.first];
        
        if (![viewController isKindOfClass:[UINavigationController class]] && ![viewController isKindOfClass:[BaseTabBarController class]]) {
            viewController = [[BaseNavigationController alloc] initWithRootViewController:viewController];
            [self pushNavigationController:(UINavigationController *)viewController];
        }
        ShareAppDelegate.window.rootViewController = viewController;
    }];
    
   
}

@end
