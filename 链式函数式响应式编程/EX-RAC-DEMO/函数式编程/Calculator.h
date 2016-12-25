//
//  Calculator.h
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

//返回值 block名 参数
typedef int (^valueBlock)(int value);
typedef BOOL (^boolBlock)(int value);

@interface Calculator : NSObject
/**计算结果*/
@property (nonatomic, assign) int result;

@property (nonatomic, assign) BOOL isEqual;

- (Calculator *)calculator:(valueBlock)block;

- (Calculator *)equal:(boolBlock)block;

@end
