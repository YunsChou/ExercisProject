//
//  TestModel.h
//  runtimeDictModel
//
//  Created by weiying on 16/3/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Model.h"

@class TestSubModel;

@interface TestModel : NSObject <ModelDelegate>

@property (nonatomic, copy) NSString *abc;

@property (nonatomic, copy) NSString *efg;

@property (nonatomic, copy) NSString *test;

@property (nonatomic, strong) NSDictionary *dic;
//一个模型中的子模型对象，会被作为一个字典来处理
@property (nonatomic, strong) TestSubModel *subModel;

//@property (nonatomic, strong) NSArray *subArr;
/**
 1、模型中数组的字典必须和外部对应【如果想要模型中的字典和外部不对应赋值，模型中该做如何操作】
 2、模型中数组必须要在协议中说明对应的子模型
 */
@property (nonatomic, strong) NSArray *subs;
@end

@interface TestSubModel : NSObject

@property (nonatomic, copy) NSString *today;

@property (nonatomic, copy) NSString *tommorrow;

@end
