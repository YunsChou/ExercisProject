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
@property (nonatomic, strong) RACCommand *command;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self signal];
    [self subject];
    [self sequenceAndTuple];
    [self commandAndExecut];
    [self multicastConnection];
    
    [self RACCommonUsage];
}

// RACSignal：
//使用步骤：
// 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
// 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
// 3.发送信号 - (void)sendNext:(id)value
- (void)signal
{
    //1、创建信号（冷信号）
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"触发信号 -- ");
        //3、订阅者发出信号
        [subscriber sendNext:@"订阅者发送信号"];
        [subscriber sendCompleted];
        //信号发送完成或发送错误的时候，会触发取消订阅或清理资源
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    
    //2、订阅信号（激活信号，热信号）
    [signal subscribeNext:^(id x) {
        NSLog(@"接收到的数据 -- %@", x);
    }];
}

// RACSubject：信号提供者，自己可以充当信号，又能发送信号
// eg.替换代理：例子如pushToNextClick
//使用步骤：
// 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
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
    
    [subject sendNext:@"subject发出信号"];
}

// RACSubject替换代理
- (IBAction)pushToNextClick:(id)sender {
    
    NSLog(@"跳转按钮点击 -- 原方法 -- 打印");
    
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
        NSLog(@"遍历数组array - %@", x);
    }];

    // 遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name" : @"xiaoming", @"age" : @18};
    [dict.rac_sequence.signal subscribeNext:^(id x) {
//        NSLog(@"dict -- %@", x);
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"变量字典dict - %@ : %@,", key, value);
    }];
}

// RACCommand：
// eg.网络请求：将数据通过execute传入(input)，通过command.executionSignals获取内部信号(数据变化)
// 使用步骤:
// 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
// 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
// 3.执行命令 - (RACSignal *)execute:(id)input
- (void)commandAndExecut
{
    //1、创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令 -- %@", input);
        //2、创建信号，用来传递数据
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"发送数据"];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
    //命令必须要被强引用，否则接收不到数据
    _command = command;
    
    //订阅command中的信号
    [command.executionSignals subscribeNext:^(id x) {
//       NSLog(@"command中的信号对象 -- %@", x);
       [x subscribeNext:^(id x) {
           NSLog(@"信号中发送的内容 -- %@", x);
       }];
    }];
    
    //3、执行命令
    [command execute:@1];
    
}

- (void)multicastConnection
{
    RACSignal *signal0 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送数据0");
        [subscriber sendNext:@10];
        return nil;
    }];
    
    [signal0 subscribeNext:^(id x) {
        NSLog(@"第一订阅者接收信号");
    }];
    
    [signal0 subscribeNext:^(id x) {
        NSLog(@"第二订阅者接收信号");
    }];
    
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"发送数据1");
        [subscriber sendNext:@100];
        return nil;
    }];
    
    RACMulticastConnection *connect = [signal1 publish];
    
    [signal1 subscribeNext:^(id x) {
        NSLog(@"订阅者一信号 -- %@", x);
    }];
    
    [signal1 subscribeNext:^(id x) {
        NSLog(@"订阅者二信号 -- %@", x);
    }];
    
    [connect connect];
}

#pragma mark - ARC常见用法
static NSString * const changeTextNotifiKey = @"changeTextNotifiKey";

- (void)RACCommonUsage
{
    [self insteadSelector];
    [self insteadKVO];
    [self insteadControlEvent];
    [self insteadNotifiObserver];
    [self insteadTextControlObserver];
    
    [self textSearch];
}

/**
 1、替换代理或方法
 */
- (void)insteadSelector
{
//    self rac_signalForSelector:<#(SEL)#> fromProtocol:<#(Protocol *)#>
    [[self rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        NSLog(@"页面将要出现 -- 被替换后 -- 打印");
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"页面将要出现 -- 原方法 -- 打印");
}

/**
 2、替换KVO
 */
- (void)insteadKVO
{
    [[self.label1 rac_valuesAndChangesForKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld observer:nil] subscribeNext:^(RACTuple *x) {
//        NSLog(@"x -- %@", x);
        //该元组对象中，包含-- 新值和相关的信息字典
        RACTupleUnpack(NSString *newValue, NSDictionary *info) = x;
        NSLog(@"KVO - newValue：%@ \n info：%@,", newValue, info);
        
        //内容改变后，发出通知(仅为了测试替换通知)
        [[NSNotificationCenter defaultCenter] postNotificationName:changeTextNotifiKey object:nil];
    }];
}

/**
 3、替换控件触发的事件
 */
- (void)insteadControlEvent
{
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"跳转按钮点击 -- 被替换后 -- 打印");
    }];
}

/**
 4、替换通知观察者
 */
- (void)insteadNotifiObserver
{
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:changeTextNotifiKey object:nil] subscribeNext:^(id x) {
        NSLog(@"收到内容改变后 -- 发出的通知");
    }];
}

/**
 5、替换文本框的监听方式
 */
- (void)insteadTextControlObserver
{
    [self.textField1.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"文本框内容改变 -- %@", x);
    }];
}

/**
 5.1、文本框监听延伸：实现输入内容实时搜索功能
 需要满足：（1）文本框不为空；（2）文本框数据不同时；（3）停止输入后，延迟0.5秒无输入
 同时满足以上条件，才发送请求
 */
- (void)textSearch
{
    [[[[self.textField1.rac_textSignal ignore:@""] distinctUntilChanged] throttle:0.5] subscribeNext:^(id x) {
        NSInteger random = arc4random() % 10;
        self.textLabel.text = [NSString stringWithFormat:@"%@ - %ld",x, random];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
