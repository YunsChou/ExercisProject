//
//  NewsDetailViewModel.m
//  HotLibApp
//
//  Created by weiying on 16/10/18.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsDetailViewModel.h"
#import "MJExtension.h"
#import "NewsListModel.h"
#import "CommentViewModel.h"
#import "HTTPRequestTool.h"

@interface NewsDetailViewModel ()
@property (nonatomic, strong) CommentViewModel *hotCommentViewModel;
@end

@implementation NewsDetailViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupDetailRACCommand];
    }
    return self;
}

- (void)setupDetailRACCommand
{
    @weakify(self);
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestDetailDataWithSuccess:^(NSDictionary * result) {
                NewsDetailModel *detailModel = [NewsDetailModel mj_objectWithKeyValues:result[self.listModel.docid]];
                self.detailModel = detailModel;
                [subscriber sendNext:result];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        return signal;
    }];
    
    self.fetchDetailModelCommand = command;
}

//- (void)setupHotReplyRACCommand
//{
//    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            
//            
//            return nil;
//        }];
//        return signal;
//    }];
//    
//    self.fetchHotReplyModelCommand = command;
//}

- (void)requestDetailDataWithSuccess:(void (^)(NSDictionary * result))success failure:(void (^)(NSError *error))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html", self.listModel.docid];
    [[HTTPRequestTool shareInstance] GET:urlStr parameters:nil success:^(id response) {
        if (success) {
            success(response);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - 懒加载
- (CommentViewModel *)hotCommentViewModel
{
    if (!_hotCommentViewModel) {
        self.hotCommentViewModel = [[CommentViewModel alloc] init];
    }
    return _hotCommentViewModel;
}

@end
