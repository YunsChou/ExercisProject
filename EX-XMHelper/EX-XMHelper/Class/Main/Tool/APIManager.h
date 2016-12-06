//
//  APIManager.h
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/3.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, VIDEO_TYPE) {
    VIDEO_TYPE_HERO = 1,
    VIDEO_TYPE_PLAYER,
    VIDEO_TYPE_SERIES,
    VIDEO_TYPE_ORGNIZED,
    VIDEO_TYPE_LATEST
};

@interface APIManager : NSObject

+ (NSString *)api_videoListWithVideoType:(VIDEO_TYPE)videoType;

+ (NSString *)api_videoDetailWithVideoType:(VIDEO_TYPE)videoType ID:(NSString *)ID page:(NSInteger)page;

@end
