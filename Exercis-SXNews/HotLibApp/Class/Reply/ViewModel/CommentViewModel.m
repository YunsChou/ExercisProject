//
//  HotCommentViewModel.m
//  HotLibApp
//
//  Created by weiying on 16/10/20.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "CommentViewModel.h"
#import "MJExtension.h"
#import "NewsListModel.h"
#import "HTTPRequestTool.h"

@implementation CommentViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupHotCommentRACCommand];
        [self setupNormalCommentRACCommand];
    }
    return self;
}

#pragma mark - 热门评论
- (void)setupHotCommentRACCommand
{
    @weakify(self);
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestHotCommentDataWithSuccess:^(NSDictionary *result) {
                NSArray *hotPosts = result[@"hotPosts"];
                NSMutableArray *tempMutArr = [NSMutableArray array];
                for (NSDictionary *postContent in hotPosts) {
                    NSDictionary *postDict = postContent[@"1"];
                    CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:postDict];
                    [tempMutArr addObject:commentModel];
                }
                self.hotCommentModels = tempMutArr;
                
                [subscriber sendNext:tempMutArr];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        return signal;
    }];
    
    self.fetchHotCommentModelCommand = command;
}

- (void)requestHotCommentDataWithSuccess:(void (^)(NSDictionary * result))success failure:(void (^)(NSError *error))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.listModel.boardid,self.listModel.docid];
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

#pragma mark - 普通评论
- (void)setupNormalCommentRACCommand
{
    @weakify(self);
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestNormalCommentDataWithSuccess:^(NSDictionary *result) {
                NSArray *hotPosts = result[@"newPosts"];
                NSMutableArray *tempMutArr = [NSMutableArray array];
                for (NSDictionary *postContent in hotPosts) {
                    NSDictionary *postDict = postContent[@"1"];
                    CommentModel *commentModel = [CommentModel mj_objectWithKeyValues:postDict];
                    [tempMutArr addObject:commentModel];
                }
                self.normalCommentModels = tempMutArr;
                
                [subscriber sendNext:tempMutArr];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        return signal;
    }];
    self.fetchNormalCommentModelCommand = command;
}

- (void)requestNormalCommentDataWithSuccess:(void (^)(NSDictionary * result))success failure:(void (^)(NSError *error))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/normal/%@/%@/desc/0/10/10/2/2",self.listModel.boardid,self.listModel.docid];
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

@end
