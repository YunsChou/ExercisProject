//
//  BaseViewController.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/10.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;

@property (nonatomic, strong, readonly) BaseViewModel *viewModel;

//@property (nonatomic, strong) UIView *snapshot;

- (void)bindViewModel;
@end
