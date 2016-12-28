//
//  ViewController.m
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "ViewController.h"

#import "BlockAndCFunc.h"
#import "Animal.h"
#import "Calculator.h"
#import "Person.h"
#import "Robot.h"
#import "ResponseModel.h"

@interface ViewController ()
@property (nonatomic, strong) ResponseModel *model;
@property (weak, nonatomic) IBOutlet UIButton *userNameButton;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //block和C语言函数的比较
    [self block_VS_CFunc];
    
    //函数式到链式
    [self funcToChainMethod];
    
    //函数式编程
    [self functionMethod];
    
    //链式编程
    [self chainMethod];
    
    //响应式编程
    [self responseMethod];
    
    //函数式到链式
    [self funcAndChainMethod];
}

#pragma mark - block和C语言函数比较
- (void)block_VS_CFunc
{
    BlockAndCFunc *b = [[BlockAndCFunc alloc] init];
    
    [b compareFuncAndBlock];
}

#pragma mark - 函数式过渡到链式
- (void)funcToChainMethod
{
    Animal *a = [[Animal alloc] init];
    
    //函数式调用
    [[a run] jump];
    //链式调用（Xcode⚠️提示“调用结果未使用”）
    a.run.jump;
    
    //带参数的方法，不能使用点语法调用
    [[[a run] say:@"hello"] jump];
    //❌以下为错误写法
    //a.run.say:@"hello";
}

#pragma mark - 函数式编程
- (void)functionMethod
{
    Calculator *c = [[Calculator alloc] init];
    
    BOOL isEqual = [[[c calculator:^int(int value) {
        //返回计算后的值
        value += 2;
        value *= 5;
        return value;
    }] equal:^BOOL(int value) {
        //判断计算后的值是否等于10
        return value == 10;
    }] isEqual];//获取是否等于的BOOL值
    NSLog(@"函数式编程isEqual -- %d", isEqual);
}

#pragma mark - 链式编程
- (void)chainMethod
{
    Person *p = [[Person alloc] init];
    //使用链式调用输出：小明程序员
    p.who(@"小明").work();
    
    //只使用"."和"[]"调用work方法，是等价的，但此时还无法触发内部block
    workBlock block1 = [p work];
    workBlock block2 = p.work;
    //只有在block之后调用"()"才能触发block代码块
    block1();
    block2();
    //所以下面两个方法调用结果是一样的，只是两种不同的写法
    [p work]();
    p.work();
    
    //经过上面的分析，以下代码和p.who(@"小明").work();是等价的，只是用点语法调用更加直观
    [[p who](@"小明") work]();
}

#pragma mark - 函数式和链式
- (void)funcAndChainMethod
{
    Robot *r = [[Robot alloc] init];
    //打印：机器人价值150rmb 连上网 大师帮它训练围棋用了3个小时 机器人价值180rmb
    [[[r money:^int(int money) {
        //机器价格100，额外交税50%
        money += 100;
        money *= 1.5;
        return money;
    }].netWork() learnWithTime:3](@"围棋").shutdown money:^int(int money){
        //增值了20%
        money *= 1.2;
        return money;
    }];
}

#pragma mark - 响应式编程
- (void)responseMethod
{
    ResponseModel *model = [[ResponseModel alloc] init];
    //使用KVO监听属性userName变化
    [model addObserver:self forKeyPath:@"userName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.model = model;
}

//当属性的值发生变化时，自动调用此方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //如果userName值发生改变，改变按钮上的内容
    if ([keyPath isEqualToString:@"userName"]) {
        NSString *oldName = change[@"old"];
        NSString *newName = change[@"new"];
        [self.userNameButton setTitle:oldName forState:UIControlStateNormal];
        //设置延时1秒
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.userNameButton setTitle:newName forState:UIControlStateNormal];
        });
    }
}

//点击按钮改变userName的值
- (IBAction)userNameButtonClick:(id)sender {
    //userName的值由初始化 '隔壁' 变为 '老王'
    self.model.userName = @"老王";
}

#pragma mark - 其他
- (void)dealloc
{
    [self.model removeObserver:self forKeyPath:@"userName"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
