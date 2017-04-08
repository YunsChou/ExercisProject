//
//  ViewController.m
//  runtimeSELMsg1
//
//  Created by weiying on 16/3/8.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //0、对象去找自身的实例方法，如果没找到会抛出异常
    [self performSelector:@selector(doSomething)];
}

//0.1、不实现该对象方法
//- (void)doSomething
//{
//    NSLog(@"doSomething -- ");
//}

//1、如果对象无法找到解读的消息，会调用这个方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(doSomething)) {
        NSLog(@"not find doSomething method -- ");
        //2、runtime动态添加方法：类,方法名，方法实现的函数，返回类型和参数类型
        //2.1、添加C的函数
        class_addMethod([self class], sel, (IMP)dynamicAddMethod, "v@:");
        //2.2、添加OC的方法
        class_addMethod([self class], sel, [self instanceMethodForSelector:@selector(dynamicAdd_OBJC_Method)], "v");
    }
    return [super resolveInstanceMethod:sel];
}

//2.1：C语言的函数
void dynamicAddMethod(id self, SEL _cmd){
    NSLog(@"dynamic add C method -- ");
}

//2.2：添加OC语言的方法
- (void)dynamicAdd_OBJC_Method
{
    NSLog(@"dynamic add OC dynamic -- ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
