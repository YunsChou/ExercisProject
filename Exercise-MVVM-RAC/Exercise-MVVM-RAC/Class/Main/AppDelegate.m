//
//  AppDelegate.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/8.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewModelServicesImpl.h"
#import "LoginViewModel.h"
//#import "LoginViewController.h"
#import "BaseNavigationControllerStack.h"

@interface AppDelegate ()
@property (nonatomic, strong) BaseViewModelServicesImpl *serviceImpl;
@property (nonatomic, strong) BaseNavigationControllerStack *navigationControllerStack;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.serviceImpl = [[BaseViewModelServicesImpl alloc] init];
    self.navigationControllerStack = [[BaseNavigationControllerStack alloc] initWithServices:self.serviceImpl];
    BaseViewModel *loginViewModel = [[LoginViewModel alloc] initWithServices:self.serviceImpl params:nil];
    [self.serviceImpl resetRootViewModel:loginViewModel];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
