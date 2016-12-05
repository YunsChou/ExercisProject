//
//  Calculator.h
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef int (^valueBlock)(int value);
typedef BOOL (^boolBlock)(int value);

@interface Calculator : NSObject

@property (nonatomic, assign) int result;

@property (nonatomic, assign) BOOL isEqual;

- (Calculator *)calculator:(valueBlock)block;

- (Calculator *)equal:(boolBlock)block;

@end
