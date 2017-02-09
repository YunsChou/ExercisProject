//
//  NSObject+Model.h
//  runtimeDictModel
//
//  Created by weiying on 16/3/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ModelDelegate <NSObject>

@optional
+ (NSDictionary *)replacedKeyFromePropertyName;

+ (NSDictionary *)arrayContainModelClass;

@end

@interface NSObject (Model) <ModelDelegate>

+ (instancetype)modelWithDict:(NSDictionary *)dict;

/**优化后的方法*/
+ (instancetype)objectWithDict:(NSDictionary *)dict;

@end
