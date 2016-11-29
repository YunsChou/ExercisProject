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
    
//    RAC(self, avatarURL) = [RACObserve(self, username) map:^id(id value) {
//        
//    }];
    
    self.validLoginSignal = [[RACSignal combineLatest:@[RACObserve(self, username), RACObserve(self, password)] reduce:^(NSString *username, NSString * password){
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
    
    // 浏览器登陆命令
    self.browserLoginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        
        OAuthViewModel *viewModel = [[OAuthViewModel alloc] initWithServices:self.services params:nil];
        
        viewModel.callBack = ^(NSString *code){
            @strongify(self);
            
            [self.services popViewModelAnimated:YES];
            [self.exchangeTokenCommand execute:code];
        };
        
        [self.services pushViewModel:viewModel animated:YES];
        
        return [RACSignal empty];
    }];
    
    // 更改token命令
    self.exchangeTokenCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *code) {
        OCTClient *client = [[OCTClient alloc] initWithServer:[OCTServer dotComServer]];
        
        return [[[[[client exchangeAccessTokenWithCode:code] doNext:^(OCTAccessToken *accessToken) {
            [client setValue:accessToken.token forKey:@"token"];
        }] flattenMap:^RACStream *(id value) {
            return [[client fetchUserInfo] doNext:^(OCTUser *user) {
                NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
                [mutableDict addEntriesFromDictionary:user.dictionaryValue];
                if (user.rawLogin.length == 0) {
                    mutableDict[@keypath(user.rawLogin)] = user.login;
                }
                
                user = [OCTUser modelWithDictionary:mutableDict error:NULL];
                [client setValue:user forKey:@"user"];
            }];
        }] mapReplace:client] doNext:doNext];
    }];
    
}

- (void)setUsername:(NSString *)username
{
    _username = [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end
