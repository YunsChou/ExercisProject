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
@property (nonatomic, strong, readwrite) NSArray *detailList;
@end

@implementation VideoDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupCommand];
    }
    return self;
}

- (void)setupCommand
{
    @weakify(self);
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *urlString) {
        
        return [[[HTTPRequest sharedInstance] fetchJSONFromUrlString:urlString errorHandler:^{
            
        }] doNext:^(NSArray *detailArray) {
            DLog(@"detailArr - %@", detailArray);
            @strongify(self);
            self.detailList = [VideoDetailModel mj_objectArrayWithKeyValuesArray:detailArray];
        }];
    }];
    
    self.command = command;
}

@end
