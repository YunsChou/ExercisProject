//
//  NSObject+Normal.m
//  runtimeAddProperty
//
//  Created by weiying on 16/3/10.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "NSObject+Normal.h"

@implementation NSObject (Normal)
//变量法
static id _obj = nil;

- (void)setObject:(id)object
{
    _obj = object;
}

- (id)object
{
    return _obj;
}

//容器法
static NSMutableDictionary *_dict;
static NSString * const objID = @"objID";

+ (void)load
{
    _dict = [NSMutableDictionary dictionary];
}

- (void)setContainObject:(id)containObject
{
    [_dict setObject:containObject forKey:objID];
}

- (id)containObject
{
    return [_dict objectForKey:objID];
}

+ (void)testCategoryMethod
{
    NSLog(@"selfClass ---- %@",self);
}

@end
