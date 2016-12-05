//
//  NSObject+Calculator.h
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CalculateManager.h"

@interface NSObject (Calculator)

+ (int)makeCalculators:(void (^)(CalculateManager *make))calculator;

@end
