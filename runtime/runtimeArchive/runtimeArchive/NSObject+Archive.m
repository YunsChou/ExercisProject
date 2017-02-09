//
//  NSObject+Archive.m
//  runtimeArchive
//
//  Created by weiying on 16/5/19.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "NSObject+Archive.h"
#import <objc/runtime.h>

@implementation NSObject (Archive)

/**归档*/
- (void)ys_encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        //获取成员变量名称（key），带下划线
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *keyName = [NSString stringWithUTF8String:ivarName];
        //需要忽略的字段
//        if ([self respondsToSelector:@selector(ys_ignoredCodingPropertyName)]) {
//            if ([[self ys_ignoredCodingPropertyName] containsObject:keyName]) continue;
//        }
        //根据key获取value
        id value = [self valueForKey:keyName];
        //进行归档
        [aCoder encodeObject:value forKey:keyName];
    }
    free(ivarList);
}

/**解归档*/
- (void)ys_decodeWithCoder:(NSCoder *)aDecoder
{
    unsigned int count = 0;
    //获取成员变量列表
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        //获取成员变量名称（key），带下划线
        Ivar ivar = ivarList[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *keyName = [NSString stringWithUTF8String:ivarName];
        //需要忽略的字段
//        if ([self respondsToSelector:@selector(ys_ignoredCodingPropertyName)]) {
//            if ([[self ys_ignoredCodingPropertyName] containsObject:keyName]) continue;
//        }
        //根据key取出归档中的value
        id value = [aDecoder decodeObjectForKey:keyName];
        //KVC赋值回去
        [self setValue:value forKey:keyName];
    }
    free(ivarList);
}

@end
