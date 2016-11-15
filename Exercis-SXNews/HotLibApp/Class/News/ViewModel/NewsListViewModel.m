//
//  NewsListViewModel.m
//  HotLibApp
//
//  Created by weiying on 16/9/13.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsListViewModel.h"
#import "MJExtension.h"
#import "NewsListModel.h"
#import "HTTPRequestTool.h"

@implementation NewsListViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupRACCommand];
    }
    return self;
}

- (void)setupRACCommand
{
    @weakify(self);
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self);
            [self requestListDataWithUrlStr:input success:^(NSArray *array) {
                NSArray *newsModelArr = [NewsListModel mj_objectArrayWithKeyValuesArray:array];
                [subscriber sendNext:newsModelArr];
                [subscriber sendCompleted];
            } failure:^(NSError *error) {
                [subscriber sendError:error];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
        return signal;
    }];
    
    self.fetchListModelCommand = command;
}

- (void)requestListDataWithUrlStr:(NSString *)urlStr success:(void (^)(NSArray * array))success failure:(void (^)(NSError *error))failure
{
    NSString *allUrlStr = [@"http://c.m.163.com/nc/article/" stringByAppendingString:urlStr];
    [[HTTPRequestTool shareInstance] GET:allUrlStr parameters:nil success:^(NSDictionary *response) {
        NSString *key = [response.keyEnumerator nextObject];
        NSArray *temArray = response[key];
        DLog(@"key - %@, ",key);
        if (success) {
            success(temArray);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
