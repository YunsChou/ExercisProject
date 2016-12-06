//
//  VideoListViewModel.m
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoListViewModel.h"
#import "HTTPRequest.h"
#import "VideoListModel.h"

@interface VideoListViewModel ()
@property (nonatomic, assign, readwrite) VIDEO_TYPE type;
@property (nonatomic, strong, readwrite) NSArray *videoList;
@end

@implementation VideoListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = VIDEO_TYPE_PLAYER;
        RAC(self, type) = [RACObserve(self, segmentType) map:^id(NSNumber *value) {
            return @(value.integerValue + 2);
        }];
    }
    return self;
}

- (RACSignal *)refreshObjectWithErrorHandler:(void (^)())errorHandler
{
    NSString *urlString = [APIManager api_videoListWithVideoType:self.type];
    
    @weakify(self);
    RACSignal *signal = [[[HTTPRequest sharedInstance] fetchJSONFromUrlString:urlString errorHandler:^{
        errorHandler();
    }] doNext:^(NSArray *listArray) {
        @strongify(self);
        
        self.videoList = [VideoListModel mj_objectArrayWithKeyValuesArray:listArray];
    }];
    
    return signal;

}

@end
