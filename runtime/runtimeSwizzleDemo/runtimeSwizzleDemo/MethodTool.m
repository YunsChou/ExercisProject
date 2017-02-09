//
//  MethodTool.m
//  runtimeSwizzleDemo
//
//  Created by weiying on 16/5/19.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "MethodTool.h"

@implementation MethodTool

+ (instancetype)shareMethodTool
{
    static MethodTool *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        _instance.countNum = 0;
    });
    return _instance;
}

- (void)addCount
{
    _countNum ++;
    
    NSLog(@"点击次数 -- %ld",_countNum);
}

@end
