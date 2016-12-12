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
    //block和C语言函数的比较
    [self compareFuncAndBlock];
    //链式编程
    [self chainMethod0];
    [self chainMethod1];
    //函数式编程
    [self functionMethod];
    //响应式编程
    [self responseMethod];
}

#pragma mark - block和C语言函数比较
//返回值 block名 参数列表
typedef int (^minBlock)(int a, int b);

//返回值 函数名 参数列表
int maxFunc(int a, int b)
{
    NSLog(@"3、比较a和b的最大值");
    return MAX(a, b);
}

- (void)compareFuncAndBlock
{
    //使用block：先定义，再调用，调用时参数放在block"()"之后
    minBlock block = ^(int a, int b){
        NSLog(@"1、比较a和b的最小值");
        return MIN(a, b);
    };
    int minNum = block(10, 20);
    NSLog(@"2、a和b的最小值为 -- %d", minNum);
    
    //使用函数：先定义，再调用，调用时参数放在函数"()"之后
    int maxNum = maxFunc(10, 20);
    NSLog(@"4、a和b的最大值为 -- %d", maxNum);
}

#pragma mark - 链式编程
- (void)chainMethod0
{
    Person *p = [[Person alloc] init];
    //使用链式调用输出：小明程序员
    p.who(@"小明").work();
    
    //只使用"."和"[]"调用work方法，是等价的，但此时还无法触发内部block
    workBlock block1 = [p work];
    workBlock block2 = p.work;
    //只有调用在block之后调用"()"才能触发block代码块
    block1();
    block2();
    //所以下面两个方法调用结果是一样的，只是两种不同的写法
    [p work]();
    p.work();
    
    //同理，下面的方法和p.who(@"小明").work();是等价的，只是用点语法调用更加直观
    [[p who](@"xiaohong") work]();
    
    //无法使用"."调用带有参数的方法，使用"[]"调用workWithTime:方法
    //p.workWithTime;
    [p workWithTime:8];

    //使用"."调用普通无参数方法，Xcode提示“调用结果未使用”
    p.testNoParamsFunc;
    //使用"[]"调用方法接触警告
    [p testNoParamsFunc];
}

- (void)chainMethod1
{
    CalculateManager *mgr = [[CalculateManager alloc] init];
    //使用链式调用，获取计算后的返回值
    int result0 = mgr.add(10).add(1).sub(2).result;
    NSLog(@"链式编程result0 -- %d", result0);
    
    //对以上链式调用添加扩展后，实现类似masonry一样的调用
    /**
     这种调用方式，可以看做是链式调用和函数式调用的结合
     因为makeCalculators:方法可以返回一个可继续进行下一步操作的对象
     */
    int result1 = [NSObject makeCalculators:^(CalculateManager *make) {
        make.add(10).add(2).sub(1);
    }];
    NSLog(@"链式编程result1 -- %d",result1);
    
}

#pragma mark - 函数式编程
- (void)functionMethod
{
    Calculator *c = [[Calculator alloc] init];
    
    BOOL isEqual = [[[c calculator:^int(int value) {//返回计算后的值
        value += 2;
        value *= 5;
        return value;
    }] equal:^BOOL(int value) {//判断计算后的值是否等于10
        return value == 10;
    }] isEqual];//获取是否等于的BOOL值
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
