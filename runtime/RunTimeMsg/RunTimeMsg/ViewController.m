//
//  ViewController.m
//  RunTimeMsg
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
    
    [self performSelector:@selector(doSomething)];
}

//1、对象无法解读消息，会调用这个方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(doSomething)) {
        NSLog(@"doSomething method in here");
        //2、runtime动态添加方法：类,方法名，方法实现的函数，返回类型和参数类型
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//2.1：C语言的函数
void dynamicMethodIMP (id self, SEL _cmd){
    NSLog(@"doSomething add dynamic method");
}

//2.2：错误，必须是C语言的函数
//- (void)dynamicMethodIMP
//{
//    NSLog(@"doSomething add dynamic method");
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
