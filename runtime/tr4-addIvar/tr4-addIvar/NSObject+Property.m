//
//  NSObject+Property.m
//  tr4-addIvar
//
//  Created by weiying on 16/3/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

- (NSString *)name
{
    return objc_getAssociatedObject(self, @"name");
}

- (void)setName:(NSString *)name
{
    return objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
