//
//  BaseNavigationProtocol.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseNavigationProtocol <NSObject>

- (void)pushViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated;

- (void)popViewModelAnimated:(BOOL)animated;

- (void)popToRootViewModelWithAnimated:(BOOL)animated;

- (void)presentViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion;

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion;


- (void)resetRootViewModel:(BaseViewModel *)viewModel;
@end
