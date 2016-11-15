//
//  BaseViewController.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/10.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, strong, readwrite) BaseViewModel *viewModel;
@end

@implementation BaseViewController

#pragma mark - life cycle
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    BaseViewController *baseViewController = [BaseViewController allocWithZone:zone];
    
    @weakify(baseViewController);
    [[baseViewController rac_signalForSelector:@selector(initWithViewModel:)] subscribeNext:^(id x) {
        @strongify(baseViewController);
        
        [baseViewController bindViewModel];
    }];
    
    return baseViewController;
}

- (instancetype)initWithViewModel:(BaseViewModel *)viewModel
{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.viewModel.willDisappearSignal sendNext:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)bindViewModel
{
    RAC(self, title) = RACObserve(self.viewModel, title);
    
    @weakify(self);
    [self.viewModel.errors subscribeNext:^(NSError *error) {
        @strongify(self);
        
        DLogError(error);
        
        if ([error.domain isEqual:OCTClientErrorDomain] && error.code == OCTClientErrorAuthenticationFailed) {
            DLog(@"授权已过期 -- ");
        }else if (error.code != OCTClientErrorTwoFactorAuthenticationOneTimePasswordRequired && error.code != OCTClientErrorConnectionFailed){
            DLogError(error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
