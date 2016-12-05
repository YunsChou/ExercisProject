//
//  CalculateManager.m
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "CalculateManager.h"

@implementation CalculateManager

- (CalculateManagerBlock)add
{
    CalculateManagerBlock addBlock = ^CalculateManager * (float value){
        _result += value;
        return self;
    };
    
    return addBlock;
}

- (CalculateManagerBlock)sub
{
    CalculateManagerBlock subBlock = ^(float value){
        _result -= value;
        return self;
    };
    
    return subBlock;
}

- (CalculateManagerBlock)muilt
{
    CalculateManagerBlock muiltBlock = ^(float value){
        _result *= value;
        return self;
    };
    
    return muiltBlock;
}

- (CalculateManagerBlock)divide
{
    CalculateManagerBlock divideBlock = ^(float value){
        _result /= value;
        return self;
    };
    
    return divideBlock;
}

@end
