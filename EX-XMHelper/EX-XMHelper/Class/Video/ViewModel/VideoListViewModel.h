//
//  VideoListViewModel.h
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"

typedef NS_ENUM(NSUInteger, VideoListSegmentType) {
    VideoListSegmentTypePlayer,
    VideoListSegmentTypeSeries,
    VideoListSegmentTypeOrgnized,
};

@interface VideoListViewModel : NSObject

@property (nonatomic, assign, readonly) VIDEO_TYPE type;

@property (nonatomic, assign) VideoListSegmentType segmentType;

@property (nonatomic, strong, readonly) NSArray *videoList;

//@property (nonatomic, copy, readonly) NSString *titleText;
//
//@property (nonatomic, copy, readonly) NSString *imageSrc;

- (RACSignal *)refreshObjectWithErrorHandler:(void(^)())errorHandler;

@end
