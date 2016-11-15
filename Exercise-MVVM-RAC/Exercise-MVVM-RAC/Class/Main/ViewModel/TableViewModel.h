//
//  TableViewModel.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseViewModel.h"

@interface TableViewModel : BaseViewModel

/// tableView 数据源
@property (nonatomic, strong) NSArray *dataSource;

/// tableView 分组title数组
@property (nonatomic, strong) NSArray *sectionTitles;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger limit;

@property (nonatomic, assign) BOOL shouldPullToRefresh;
@property (nonatomic, assign) BOOL shouldInfiniteScrolling;

@property (nonatomic, copy) NSString *keyword;

@property (nonatomic, strong) RACCommand *didSelectCommand;
@property (nonatomic, strong, readonly) RACCommand *requetRemoteDataCommand;

- (id)fetchLocalData;
- (BOOL (^)(NSError *error))requestRomoteDataErrorsFilter;
- (NSInteger)offsetForPage:(NSInteger)page;
- (RACSignal *)requestRemoteDataSignalWithPage:(NSInteger)page;
@end
