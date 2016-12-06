//
//  VideoDetailViewModel.m
//  EX-XMHelper
//
//  Created by weiying on 2016/12/6.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoDetailViewModel.h"
#import "HTTPRequest.h"
#import "VideoDetailModel.h"

@interface VideoDetailViewModel ()
@property (nonatomic, strong, readwrite) NSMutableArray *detailList;
@property (nonatomic, assign) NSInteger page;
@end

@implementation VideoDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.page = 1;
        self.detailList = [NSMutableArray array];
//        [self setupCommand];
    }
    return self;
}

//- (void)setupCommand
//{
//    @weakify(self);
//    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *urlString) {
//        
//        return [[[HTTPRequest sharedInstance] fetchJSONFromUrlString:urlString] doNext:^(NSArray *detailArray) {
//            DLog(@"detailArr - %@", detailArray);
//            @strongify(self);
//            self.detailList = [VideoDetailModel mj_objectArrayWithKeyValuesArray:detailArray];
//        }];
//    }];
//    
//    self.command = command;
//}

- (RACSignal *)fetchLatestObjects
{
    self.page = 1;
    return [self fetchObjects];
}

- (RACSignal *)fetchMoreObjects
{
    self.page ++;
    return [self fetchObjects];
}

- (RACSignal *)fetchObjects
{
    @weakify(self);
    NSString *urlString = [APIManager api_videoDetailWithVideoType:_type ID:_ID page:self.page];
    return [[[[HTTPRequest sharedInstance] fetchJSONFromUrlString:urlString] doNext:^(NSArray *detailArray) {
        @strongify(self);
        NSArray *detailArr = [VideoDetailModel mj_objectArrayWithKeyValuesArray:detailArray];
        if (self.page == 1) {
            [self.detailList removeAllObjects];
        }
        [self.detailList addObjectsFromArray:detailArr];
    }] doError:^(NSError *error) {
        if (self.page != 1) {
            self.page --;
        }
    }];
}

@end
