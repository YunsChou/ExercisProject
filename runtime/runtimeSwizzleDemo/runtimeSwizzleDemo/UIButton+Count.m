//
//  UIButton+Count.m
//  runtimeSwizzleDemo
//
//  Created by weiying on 16/5/19.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "UIButton+Count.h"
#import <objc/runtime.h>

@implementation UIButton (Count)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSel = @selector(sendAction:to:forEvent:);
        SEL customSel = @selector(my_sendAction:to:forEvent:);
        Method originM = class_getInstanceMethod([self class], originSel);
        Method customM = class_getInstanceMethod([self class], customSel);
        method_exchangeImplementations(originM, customM);
        //先尝试给原方法添加实现【这里是为了避免原方法没有实现】
        //原理：若已经存在，则会添加失败
        BOOL addResult = class_addMethod([self class], originSel, method_getImplementation(customM), method_getTypeEncoding(customM));
//        addResult = class_addMethod([self class], originSel, method_getImplementation(customM), method_getTypeEncoding(customM));
        if (addResult) {//添加成功：将原方法的实现 替换 待交换方法的实现
            NSLog(@"添加成功 -- ");
            class_replaceMethod([self class], customSel, method_getImplementation(originM), method_getTypeEncoding(originM));
        }else{//添加失败：说明原方法已经实现，那么直接交换两个方法即可
            method_exchangeImplementations(originM, customM);
        }
    });
}

//自定义的方法
- (void)my_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event
{
    NSLog(@"外部调用的是系统的方法，这里触发的是我自定义的方法 -- ");
    [self my_sendAction:action to:target forEvent:event];
}

@end
