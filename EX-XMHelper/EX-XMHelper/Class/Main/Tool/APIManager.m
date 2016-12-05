//
//  APIManager.m
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/3.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

+ (NSString *)api_videoListWithVideoType:(VIDEO_TYPE)videoType
{
    NSInteger arc = arc4random()%1000000 +100000;
    if (VIDEO_TYPE_LATEST == videoType) {
        NSString *string = [NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/videolist_99.json?r=%ld", (long)arc];
        return string;
    }
    
    NSString *string = [NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/videotype_%ld.json?r=%ld", (long)videoType, (long)arc];
    return string;
}

+ (NSString *)api_seriesWithType:(VIDEO_TYPE)videoType name:(NSString *)name page:(NSInteger)page
{
    NSInteger arc = arc4random()%1000000 +100000;
    NSString *string = [NSString stringWithFormat:@"http://lolbox.oss.aliyuncs.com/json/v4/video/videolist_%ld_%@_%ld.json?r=%ld",(long)videoType, name, (long)page, (long)arc];
    return string;
}

@end
