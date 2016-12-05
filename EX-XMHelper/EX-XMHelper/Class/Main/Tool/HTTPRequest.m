//
//  HTTPRequest.m
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/3.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "HTTPRequest.h"

@interface HTTPRequest ()
@property (nonatomic, strong) NSURLSession *session;
@end

@implementation HTTPRequest

+ (instancetype)sharedInstance
{
    static HTTPRequest *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:configuration];
    }
    return self;
}

- (RACSignal *)fetchJSONFromUrlString:(NSString *)urlString errorHandler:(void(^)())errorHandler
{
    @weakify(self);
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    [subscriber sendNext:json];
                }else{
                    [subscriber sendError:jsonError];
                }
            }else{
                [subscriber sendError:error];
            }
            return [subscriber sendCompleted];
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doError:^(NSError *error) {
        return errorHandler(error);
    }];
    
    return signal;
}

@end
