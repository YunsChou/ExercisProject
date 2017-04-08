//
//  SecondController.m
//  runtimeSELMsg2
//
//  Created by weiying on 16/3/8.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "SecondController.h"
#import <objc/runtime.h>

@interface SecondController ()

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//2.1、在第二个控制器中实现 该方法
- (void)secondVCDoSomething
{
    NSLog(@"secondVC do something -- ");
}

//如果第二个控制器中也没找到这个方法，也可以用runtime再次传递
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    class_addMethod([self class], sel, (IMP)secondVCDo, "v@:");
//    return YES;
//}
//
//void secondVCDo(id self, SEL _cmd){
//    NSLog(@"secondVC do something -- ");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
