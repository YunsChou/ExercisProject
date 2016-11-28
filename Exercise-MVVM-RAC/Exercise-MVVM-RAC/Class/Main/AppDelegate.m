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
#import "LoginViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) BaseViewModelServicesImpl *serviceImpl;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    LoginViewController *loginVC = [[[NSBundle mainBundle] loadNibNamed:@"LoginViewController" owner:nil options:nil] firstObject];

    self.window.rootViewController = loginVC;

    self.serviceImpl = [[BaseViewModelServicesImpl alloc] init];
//    BaseViewModel *loginViewModel = [[LoginViewModel alloc] initWithServices:self.serviceImpl params:nil];
//    [self.serviceImpl resetRootViewModel:loginViewModel];
    
    [self.window makeKeyAndVisible];
    return YES;
}



@end
