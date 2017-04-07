//
//  Robot.h
//  EX-RAC-DEMO
//
//  Created by weiying on 2017/4/7.
//  Copyright © 2017年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Robot;

typedef int (^moneyBlock) (int money);

typedef Robot * (^netBlock) ();

typedef Robot * (^learnBlock) (NSString *learn);

@interface Robot : NSObject

@property (nonatomic, assign) int money;

- (Robot *)money:(moneyBlock)block;

- (netBlock)netWork;

- (learnBlock)learnWithTime:(int)time;

- (Robot *)shutdown;

@end
