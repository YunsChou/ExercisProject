//
//  ViewController.m
//  runtimeAddProperty
//
//  Created by weiying on 16/3/10.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Normal.h"
#import "NSObject+Runtime.h"
#import "NSString+ObjSubKind.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *obj = [NSObject new];
    //变量法
    obj.object = @"abc";
    NSLog(@"object -- %@",obj.object);
    //容器法
    obj.containObject = @"hellow wolrd";
    NSLog(@"containObject -- %@",obj.containObject);
    //runtime法
    obj.runtimeObject = @"runtime给分类添加属性";
    NSLog(@"runtimeObject -- %@",obj.runtimeObject);
    //runtime关联法精简版
    obj.runtimeObj = @"runtime给分类添加属性，精简版";
    NSLog(@"runtimeObj -- %@",obj.runtimeObj);
    
    [NSObject testCategoryMethod];
    [NSString test];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
