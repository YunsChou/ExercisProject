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
@property (nonatomic, strong, readwrite) NSArray *videoList;
@end

@implementation VideoListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.type = VIDEO_TYPE_PLAYER;
    }
    return self;
}

- (RACSignal *)refreshObjectWithErrorHandler:(void (^)())errorHandler
{
    NSString *urlString = [APIManager api_videoListWithVideoType:self.type];
    
    @weakify(self);
    RACSignal *signal = [[[HTTPRequest sharedInstance] fetchJSONFromUrlString:urlString errorHandler:^{
        errorHandler();
    }] doNext:^(NSArray *videoArray) {
        @strongify(self);
        
        self.videoList = [VideoListModel mj_objectArrayWithKeyValuesArray:videoArray];
    }];
    
    return signal;

}

@end
