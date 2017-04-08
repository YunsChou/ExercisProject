//
//  ViewController.m
//  runtimeGetInside
//
//  Created by weiying on 16/3/10.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, assign) NSInteger userAge;
@end

@implementation ViewController
{
    NSString *_sayHello;
}

+ (void)load
{
    unsigned int count;
    //获取属性列表
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"propertyName -- %@",[NSString stringWithUTF8String:propertyName]);
    }
    
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        const char *ivarName = ivar_getName(ivarList[i]);
        NSLog(@"ivarName -- %@",[NSString stringWithUTF8String:ivarName]);
    }
    
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Method method = methodList[i];
        NSLog(@"methodName -- %@",NSStringFromSelector(method_getName(method)));
    }
    
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Protocol *protocal = protocolList[i];
        const char *protocalName = protocol_getName(protocal);
        NSLog(@"protocalName -- %@", [NSString stringWithUTF8String:protocalName]);
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
