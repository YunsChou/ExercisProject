//
//  LoginViewModel.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/10.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "LoginViewModel.h"
#import "HomePageViewModel.h"
#import "OAuthViewModel.h"

@interface LoginViewModel ()
@property (nonatomic, copy, readwrite) NSURL *avatarURL;
@property (nonatomic, strong, readwrite) RACSignal *validLoginSignal;
@property (nonatomic, strong, readwrite) RACCommand *loginCommand;
@property (nonatomic, strong, readwrite) RACCommand *browserLoginCommand;
@property (nonatomic, strong, readwrite) RACCommand *exchangeTokenCommand;
@end

@implementation LoginViewModel

- (void)initialize
{
    [super initialize];

    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^(NSString *username, NSString * password){
        DLog(@"username -- %@", username);
        return @(username.length > 0 && password.length > 0);
    }] distinctUntilChanged];
    
    @weakify(self)
    // 定义doNext block
    void (^doNext)(OCTClient *) = ^(OCTClient *authenticatedClient){
        @strongify(self)
        
        [[MemoryCache sharedInstance] setObject:authenticatedClient forKey:@"currentUser"];
        
        self.services.octClient = authenticatedClient;
        
        HomePageViewModel *viewModel = [[HomePageViewModel alloc] initWithServices:self.services params:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.services resetRootViewModel:viewModel];
        });
    };
    
    // 客服端授权
    [OCTClient setClientID:MRC_CLIENT_ID clientSecret:MRC_CLIENT_SECRET];
    
    // 登陆命令
    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *oneTimePassword) {
        @strongify(self);
        OCTUser *user = [OCTUser userWithRawLogin:self.username server:OCTServer.dotComServer];
        return [[OCTClient signInAsUser:user password:self.password oneTimePassword:oneTimePassword scopes:OCTClientAuthorizationScopesUser | OCTClientAuthorizationScopesRepository note:nil noteURL:nil fingerprint:nil] doNext:doNext];
    }];
}

- (void)setUsername:(NSString *)username
{
    _username = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
