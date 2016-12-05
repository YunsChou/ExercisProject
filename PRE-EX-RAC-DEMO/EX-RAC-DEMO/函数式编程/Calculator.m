//
//  Calculator.m
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (Calculator *)calculator:(valueBlock)block
{
    NSLog(@"result -- %d", _result);
    _result = block(_result);
    NSLog(@"result -- %d", _result);
    return self;
}

- (Calculator *)equal:(boolBlock)block
{
    _isEqual = block(_result);
    return self;
}

@end
