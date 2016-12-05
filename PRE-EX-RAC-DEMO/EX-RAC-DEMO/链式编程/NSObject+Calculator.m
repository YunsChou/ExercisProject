//
//  NSObject+Calculator.m
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NSObject+Calculator.h"

@implementation NSObject (Calculator)

+ (int)makeCalculators:(void (^)(CalculateManager *))calculator
{
    CalculateManager *mgr = [[CalculateManager alloc] init];
    
    calculator(mgr);
    
    return mgr.result;
}

@end
