//
//  ViewController.m
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self signal];
    [self subject];
    [self sequenceAndTuple];
}

// RACSignal
//使用步骤：
// 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
// 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
// 3.发送信号 - (void)sendNext:(id)value
- (void)signal
{
    //1、创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //2、订阅者发出信号（先保存）
        [subscriber sendNext:@"订阅者发送信号"];
        [subscriber sendCompleted];
        //信号发送完成或发送错误的时候，会触发取消订阅或清理资源
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    
    //3、订阅信号（激活信号）
    [signal subscribeNext:^(id x) {
        NSLog(@"接收到的数据 -- %@", x);
    }];
}

// RACSubject
//使用步骤：
// 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
// 可以先订阅信号，也可以先发送信号
// 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
// 3.发送信号 sendNext:(id)value
- (void)subject
{
    RACSubject *subject = [RACSubject subject];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者 -- %@", x);
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者 -- %@", x);
    }];
    
    [subject sendNext:@"subject订阅者发出信号"];
}

// RACSubject替换代理
- (IBAction)pushToNextClick:(id)sender {
    
    TestViewController *testVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TestViewController"];
    
    testVC.signal = [RACSubject subject];
    
    [testVC.signal subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮");
        self.label1.text = [x description];
    }];
    
    [self.navigationController pushViewController:testVC animated:YES];
}

// 遍历数组/遍历字典，这里其实是三步
// 第一步: 把数组转换成集合RACSequence obj.rac_sequence
// 第二步: 把集合RACSequence转换RACSignal信号类,obj.rac_sequence.signal
// 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
- (void)sequenceAndTuple
{
    // 遍历数组,遍历出来的是数组中的元素
    NSArray *array = @[@1, @2, @3, @4, @"对象"];
    [array.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"array - %@", x);
    }];

    // 遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name" : @"xiaoming", @"age" : @18};
    [dict.rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"dict -- %@", x);
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"dict - %@ : %@,", key, value);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
