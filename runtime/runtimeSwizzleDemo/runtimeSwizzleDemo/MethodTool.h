//
//  MethodTool.h
//  runtimeSwizzleDemo
//
//  Created by weiying on 16/5/19.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MethodTool : NSObject

@property (nonatomic, assign) NSInteger countNum;

+ (instancetype)shareMethodTool;

- (void)addCount;
@end
