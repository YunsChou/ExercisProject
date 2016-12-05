//
//  VideoListModel.m
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoListModel.h"

@implementation VideoListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"itemID" : @"id"};
}

@end
