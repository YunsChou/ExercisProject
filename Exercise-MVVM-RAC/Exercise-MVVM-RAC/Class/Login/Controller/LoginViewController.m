//
//  LoginViewController.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/29.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *avatarButton;
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (nonatomic, strong, readonly) LoginViewModel *viewModel;

@end

@implementation LoginViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton setTitle:@"Input" forState:UIControlStateDisabled];
    [self.loginButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
}

- (void)bindViewModel
{
    [super bindViewModel];
    RAC(self.viewModel, username) = self.usernameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    
    RAC(self.loginButton, enabled) = self.viewModel.validLoginSignal;
    
    @weakify(self)
    
    [[self.loginButton
      rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         @strongify(self)
         [self.viewModel.loginCommand execute:nil];
     }];
    
    
    [[[RACSignal
      	merge:@[self.viewModel.loginCommand.executing]]
      doNext:^(id x) {
          @strongify(self)
          [self.view endEditing:YES];
      }]
    	subscribeNext:^(NSNumber *executing) {
            @strongify(self)
            if (executing.boolValue) {
                [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES].label.text = @"Logging in...";
            } else {
                [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            }
        }];
    
    [[RACSignal
      merge:@[self.viewModel.loginCommand.errors]]
     subscribeNext:^(NSError *error) {
         if ([error.domain isEqual:OCTClientErrorDomain] && error.code == OCTClientErrorAuthenticationFailed) {
             DLogError(@"Incorrect username or password");
         } else {
             DLogError(error.localizedDescription);
         }
     }];
}

@end
