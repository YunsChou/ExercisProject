//
//  AppDelegate.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/8.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationControllerStack.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong, readonly) BaseNavigationControllerStack *navigationControllerStack;

@end

