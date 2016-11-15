//
//  BaseViewModel.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/9.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BaseViewModelServices;

typedef NS_ENUM(NSUInteger, BaseTitleViewType) {
    BaseTitleViewTypeDefault,
    BaseTitleViewTypeDoubleTitle,
    BaseTitleViewTypeLoadingTitle,
};

@interface BaseViewModel : NSObject

- (instancetype)initWithServices:(id<BaseViewModelServices>)services params:(NSDictionary *)params;

@property (nonatomic, strong, readonly) id<BaseViewModelServices> services;
@property (nonatomic, strong, readonly) NSDictionary *params;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) VoidBlock_id callBack;

@property (nonatomic, assign) BOOL shouldFetchLocalDataOnViewModelInitialize;
@property (nonatomic, assign) BOOL shouldFetchRequestRemoteDataOnViewDidLoad;

@property (nonatomic, strong) RACSubject *errors;
@property (nonatomic, strong) RACSubject *willDisappearSignal;

- (void)initialize;
@end
