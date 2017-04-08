//
//  NSObject+Normal.h
//  runtimeAddProperty
//
//  Created by weiying on 16/3/10.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Normal)

@property (nonatomic, strong) id object;

@property (nonatomic, strong) id containObject;

+ (void)testCategoryMethod;

@end
