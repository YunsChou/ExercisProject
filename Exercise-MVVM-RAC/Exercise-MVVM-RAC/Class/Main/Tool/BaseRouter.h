//
//  BaseRouter.h
//  Exercise-MVVM-RAC
//
//  Created by Yuns on 2016/11/27.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"

@interface BaseRouter : NSObject

+ (instancetype)sharedInstance;

- (BaseViewController *)viewControllerForViewModel:(BaseViewModel *)viewModel;
@end
