//
//  ViewController.m
//  runtimeSELMsg2
//
//  Created by weiying on 16/3/8.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //0、对象去找自身的实例方法，如果没找到会抛出异常
    [self performSelector:@selector(secondVCDoSomething)];
}

//1、如果对象无法找到解读的消息，会调用这个方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return [super resolveInstanceMethod:sel];
}

//如果在+ (BOOL)resolveInstanceMethod:(SEL)sel中没有找到或者添加方法
//2、消息继续往下传递到这个方法，看看是不是有对象可以执行这个方法
//注意：aSelector代表对象中的实例方法
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    Class class = NSClassFromString(@"SecondController");
    UIViewController *vc = [class new];
    //如果对象中有这个方法，就返回SecondController的对象
    //逻辑其实是先找到有对象能执行这个方法，再返回对象
    //如果能智能获取这个方法所在的对象，在返回，会更智能
    if (aSelector == NSSelectorFromString(@"secondVCDoSomething")) {
        NSLog(@"secondVC to do this -- ");
        return vc;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
