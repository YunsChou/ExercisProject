//
//  BaseViewModel.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/9.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseViewModel.h"

@interface BaseViewModel ()
@property (nonatomic, strong, readwrite) id<BaseViewModelServices> services;
@property (nonatomic, strong, readwrite) NSDictionary *params;
@end

@implementation BaseViewModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    BaseViewModel *baseViewModel = [super allocWithZone:zone];
    
    @weakify(baseViewModel);
    [[baseViewModel rac_signalForSelector:@selector(initWithServices:params:)] subscribeNext:^(id x) {
        @strongify(baseViewModel);
        
        [baseViewModel initialize];
    }];
    
    return baseViewModel;
}

- (instancetype)initWithServices:(id<BaseViewModelServices>)services params:(NSDictionary *)params
{
    self = [super init];
    if (self) {
        self.services = services;
        self.params = params;
        self.title = params[@"title"];
        
        self.shouldFetchLocalDataOnViewModelInitialize = YES;
        self.shouldFetchRequestRemoteDataOnViewDidLoad = YES;
    }
    return self;
}

- (RACSubject *)errors
{
    if (!_errors) {
        _errors = [RACSubject subject];
    }
    return _errors;
}

- (RACSubject *)willDisappearSignal
{
    if (!_willDisappearSignal) {
        _willDisappearSignal = [RACSubject subject];
    }
    return _willDisappearSignal;
}

- (void)initialize
{

}

@end
