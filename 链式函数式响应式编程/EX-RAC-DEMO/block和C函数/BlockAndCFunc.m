//
//  BlockAndCFunc.m
//  EX-RAC-DEMO
//
//  Created by Yuns on 2016/12/25.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "BlockAndCFunc.h"

@implementation BlockAndCFunc

//返回值 block名 参数列表
typedef int (^minBlock)(int a, int b);

//返回值 函数名 参数列表
int maxFunc(int a, int b)
{
    NSLog(@"3、比较a和b的最大值");
    return MAX(a, b);
}

- (void)compareFuncAndBlock
{
    //使用block：先定义，再调用，调用时参数放在block"()"之后
    minBlock block = ^(int a, int b){
        NSLog(@"1、比较a和b的最小值");
        return MIN(a, b);
    };
    int minNum = block(10, 20);
    NSLog(@"2、a和b的最小值为 -- %d", minNum);
    
    //使用函数：先定义，再调用，调用时参数放在函数"()"之后
    int maxNum = maxFunc(10, 20);
    NSLog(@"4、a和b的最大值为 -- %d", maxNum);
}

@end
