//
//  Robot.m
//  EX-RAC-DEMO
//
//  Created by weiying on 2017/4/7.
//  Copyright © 2017年 amoby. All rights reserved.
//

#import "Robot.h"

@implementation Robot

- (Robot *)money:(moneyBlock)block
{
    _money = block(_money);
    NSLog(@"机器人价值 %d rmb", _money);
    return self;
}

- (netBlock)netWork
{
    return ^Robot *(){
        NSLog(@"连上网");
        return self;
    };
}

- (learnBlock)learnWithTime:(int)time
{
    return ^Robot * (NSString *learn){
        NSLog(@"大师帮它训练 %@ ，用了 %d 个小时", learn, time);
        return self;
    };
}

- (Robot *)shutdown
{
    NSLog(@"关机");
    return self;
}

@end
