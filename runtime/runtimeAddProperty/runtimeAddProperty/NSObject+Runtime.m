//
//  NSObject+Runtime.m
//  runtimeAddProperty
//
//  Created by weiying on 16/3/10.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <objc/runtime.h>

@implementation NSObject (Runtime)

//runtime法：关联对象
static char const *objectKey;

- (void)setRuntimeObject:(id)runtimeObject
{
    //设置关联对象：给谁设置关联对象，关联对象的key，关联的对象，关联策略
    objc_setAssociatedObject(self, objectKey, runtimeObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)runtimeObject
{
    //获取关联对象：获取谁的关联对象，根据key去获取关联对象
    return objc_getAssociatedObject(self, objectKey);
}

//选择器是方法名的唯一标识，通过方法的唯一标识作为key，不用新增任何static变量实现关联
- (void)setRuntimeObj:(id)runtimeObj
{
    objc_setAssociatedObject(self, @selector(runtimeObj), runtimeObj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)runtimeObj
{
    return objc_getAssociatedObject(self, @selector(runtimeObj));
}

@end
