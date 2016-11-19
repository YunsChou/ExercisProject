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

@interface AppDelegate ()
@property (nonatomic, strong) BaseViewModelServicesImpl *serviceImpl;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[UIViewController alloc] init];
//    self.serviceImpl = [[BaseViewModelServicesImpl alloc] init];
    
//    [self.serviceImpl resetRootViewModel:[[LoginViewModel alloc] initWithServices:self.serviceImpl params:nil]];
    
    [self.window makeKeyAndVisible];
    return YES;
}



@end
