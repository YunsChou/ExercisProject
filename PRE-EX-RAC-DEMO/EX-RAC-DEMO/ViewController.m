//
//  ViewController.m
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "ViewController.h"

#import "Person.h"
#import "CalculateManager.h"
#import "NSObject+Calculator.h"
#import "Calculator.h"
#import "ResponseModel.h"

@interface ViewController ()
@property (nonatomic, strong) ResponseModel *model;
@property (weak, nonatomic) IBOutlet UIButton *userNameButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //链式编程
    [self chainMethod0];
    [self chainMethod1];
    //函数式编程
    [self functionMethod];
    //响应式编程
    [self responseMethod];
}

#pragma mark - 链式编程
- (void)chainMethod0
{
    Person *p = [[Person alloc] init];
    p.who(@"小明").work().play(@"跑步").play(@"打球");
}

- (void)chainMethod1
{
    CalculateManager *mgr = [[CalculateManager alloc] init];
    int result0 = mgr.add(10).add(1).sub(2).result;
    NSLog(@"链式编程result0 -- %d", result0);
    
    int result1 = [NSObject makeCalculators:^(CalculateManager *make) {
        make.add(10).add(2).sub(1);
    }];
    NSLog(@"链式编程result1 -- %d",result1);
}

#pragma mark - 函数式编程
- (void)functionMethod
{
    Calculator *c = [[Calculator alloc] init];
    
    BOOL isEqual = [[[c calculator:^int(int value) {
        value += 2;
        value *= 5;
        return value;
    }] equal:^BOOL(int value) {
        return value == 10;
    }] isEqual];
    NSLog(@"函数式编程isEqual -- %d", isEqual);
}

#pragma mark - 响应式编程
- (void)responseMethod
{
    ResponseModel *model = [[ResponseModel alloc] init];
    [model addObserver:self forKeyPath:@"userName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.model = model;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"userName"]) {
        NSString *oldName = change[@"old"];
        NSString *newName = change[@"new"];
        [self.userNameButton setTitle:oldName forState:UIControlStateNormal];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.userNameButton setTitle:newName forState:UIControlStateNormal];
        });
    }
}

- (IBAction)userNameButtonClick:(id)sender {
    self.model.userName = @"老王";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
