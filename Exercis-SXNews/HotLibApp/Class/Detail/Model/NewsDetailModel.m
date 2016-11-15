//
//  NewsDetailModel.m
//  HotLibApp
//
//  Created by weiying on 16/10/19.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsDetailModel.h"
#import "MJExtension.h"

@implementation NewsDetailModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"relative_sys" : [RelateNewsModel class]};
}

@end

@implementation RelateNewsModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"newsID" : @"id"};
}

@end
