//
//  Person.m
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "Person.h"

@implementation Person

- (nameBlock)who
{
    return ^Person * (NSString *name){
        NSLog(@"%@", name);
        return self;
    };
}

- (workBlock)work
{
    NSLog(@"调用work方法");
    return ^Person * (){
        NSLog(@"程序员");
        return self;
    };
}

- (workBlock)workWithTime:(int)time
{
    NSLog(@"调用workWithTime方法");
    return ^(NSString *type){
        NSLog(@"工作%d小时之后", time);
        return self;
    };
}

- (int)testNoParamsFunc
{
    NSLog(@"测试点语法调用普通无参数方法");
    return 1;
}

@end
