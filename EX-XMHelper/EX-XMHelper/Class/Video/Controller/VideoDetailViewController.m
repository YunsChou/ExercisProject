//
//  VideoDetailViewController.m
//  EX-XMHelper
//
//  Created by weiying on 2016/12/6.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "MJRefresh.h"
#import "VideoDetailViewModel.h"
#import "VideoDetailDataSource.h"

@interface VideoDetailViewController ()
@property (nonatomic, strong) VideoDetailViewModel *viewModel;
@property (nonatomic, strong) VideoDetailDataSource *dataSource;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ID;
@end

@implementation VideoDetailViewController

#pragma mark - life cycle
- (void)setVideoType:(NSInteger)type name:(NSString *)name ID:(NSString *)ID
{
    _type = type;
    _name = name;
    _ID = ID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupSignal];
}

- (void)setupTableView
{
    [self setupHeaderRefresh];
    [self setupFooterRefresh];
    self.tableView.dataSource = self.dataSource;
}

- (void)setupSignal
{
    RAC(self, title) = RACObserve(self, name);
    //页面显示的的时候请求数据(替换事件响应方法或代理)
    RACSignal *viewAppearSignal = [self rac_signalForSelector:@selector(viewWillAppear:)];
    RACSignal *headerRefreshSignal = [self rac_signalForSelector:@selector(headerRefresh)];
    RACSignal *footerRefreshSignal = [self rac_signalForSelector:@selector(footerRefresh)];
    
//    [[RACSignal merge:@[viewAppearSignal, headerRefreshSignal]] subscribeNext:^(id x) {
//        NSString *urlString = [APIManager api_videoDetailWithVideoType:_type ID:_ID page:1];
//        [[self.viewModel.command execute:urlString] subscribeNext:^(NSArray *detailArr) {
//            [self.tableView.mj_header endRefreshing];
//            [self.tableView.mj_footer endRefreshing];
//            [self.tableView reloadData];
//        }];
//    }];
    
//    [[[[self rac_signalForSelector:@selector(footerRefresh)] flattenMap:^RACStream *(id value) {
//        return [APIManager api_videoDetailWithVideoType:_type ID:_ID page:1];
//    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
//        
//    }];
    
    [[[[RACSignal merge:@[viewAppearSignal, headerRefreshSignal]] flattenMap:^RACStream *(id value) {
        return [self.viewModel fetchLatestObjects];
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }];
    
    [[[footerRefreshSignal flattenMap:^RACStream *(id value) {
        return [self.viewModel fetchMoreObjects];
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    }];
}

#pragma mark - lazy loading
- (VideoDetailViewModel *)viewModel
{
    if (!_viewModel) {
        VideoDetailViewModel *viewModel = [[VideoDetailViewModel alloc] init];
        RAC(viewModel, ID) = RACObserve(self, ID);
        RAC(viewModel, type) = RACObserve(self, type);
        self.viewModel = viewModel;
    }
    return _viewModel;
}

- (VideoDetailDataSource *)dataSource
{
    if (!_dataSource) {
        VideoDetailDataSource *dataSource = [[VideoDetailDataSource alloc] init];
        RAC(dataSource, items) = RACObserve(self.viewModel, detailList);
        self.dataSource = dataSource;
    }
    return _dataSource;
}

@end
