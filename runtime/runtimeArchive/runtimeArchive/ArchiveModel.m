//
//  ArchiveModel.m
//  runtimeArchive
//
//  Created by weiying on 16/3/18.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "archiveModel.h"
#import <objc/runtime.h>

#import "NSObject+Archive.h"

@implementation ArchiveModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
//    unsigned int count = 0;
//    //获取成员变量列表
//    Ivar *ivarList = class_copyIvarList([self class], &count);
//    for (int i = 0; i < count; i ++) {
//        //获取成员变量名称（key），带下划线
//        Ivar ivar = ivarList[i];
//        const char *ivarName = ivar_getName(ivar);
//        NSString *keyName = [NSString stringWithUTF8String:ivarName];
//        //根据key获取value
//        id value = [self valueForKey:keyName];
//        //进行归档
//        [aCoder encodeObject:value forKey:keyName];
//    }
//    free(ivarList);
    
    [self ys_encodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
//        unsigned int count = 0;
//        //获取成员变量列表
//        Ivar *ivarList = class_copyIvarList([self class], &count);
//        for (int i = 0; i < count; i ++) {
//            //获取成员变量名称（key），带下划线
//            Ivar ivar = ivarList[i];
//            const char *ivarName = ivar_getName(ivar);
//            NSString *keyName = [NSString stringWithUTF8String:ivarName];
//            //根据key取出归档中的value
//            id value = [aDecoder decodeObjectForKey:keyName];
//            //KVC赋值回去
//            [self setValue:value forKey:keyName];
//        }
//        free(ivarList);
        [self ys_decodeWithCoder:aDecoder];
    }
    return self;
}
//
//- (NSArray *)ys_ignoredCodingPropertyName
//{
//    return @[self.abc];
//}

@end
