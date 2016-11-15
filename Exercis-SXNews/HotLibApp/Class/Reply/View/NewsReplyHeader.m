//
//  NewsReplyHeader.m
//  HotLibApp
//
//  Created by weiying on 16/10/24.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsReplyHeader.h"

@implementation NewsReplyHeader

+ (instancetype)newsHotReplyHeader
{
    return [[NSBundle mainBundle] loadNibNamed:@"NewsReplyHeader" owner:nil options:nil].firstObject;
}

+ (instancetype)newsNormalReplyHeader
{
    return [[NSBundle mainBundle] loadNibNamed:@"NewsReplyHeader" owner:nil options:nil].lastObject;
}

@end
