//
//  LoginViewModel.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/10.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginViewModel : BaseViewModel

/// 用户名称
@property (nonatomic, copy) NSString *username;

/// 用户密码
@property (nonatomic, copy) NSString *password;

/// 头像URL
@property (nonatomic, copy, readonly) NSURL *avatarURL;

/// 有效登陆 信号
@property (nonatomic, strong, readonly) RACSignal *validLoginSignal;

/// 登陆按钮 命令
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
