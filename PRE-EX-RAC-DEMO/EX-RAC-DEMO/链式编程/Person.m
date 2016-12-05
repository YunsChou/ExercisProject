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
        NSLog(@"员工：%@", name);
        return self;
    };
}

- (workBlock)work
{
    return ^Person * (){
        NSLog(@"搬了一天砖");
        return self;
    };
}

- (playBlock)play
{
    return ^(NSString *type){
        NSLog(@"玩：%@", type);
        return self;
    };
}

@end
