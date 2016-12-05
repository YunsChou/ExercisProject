//
//  CalculateManager.h
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculateManager;

typedef CalculateManager * (^CalculateManagerBlock)(float value);

@interface CalculateManager : NSObject

@property (nonatomic, assign) float result;

- (CalculateManagerBlock)add;

- (CalculateManagerBlock)sub;

- (CalculateManagerBlock)muilt;

- (CalculateManagerBlock)divide;

@end
