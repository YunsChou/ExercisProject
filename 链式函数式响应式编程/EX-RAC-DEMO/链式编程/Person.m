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

@end
