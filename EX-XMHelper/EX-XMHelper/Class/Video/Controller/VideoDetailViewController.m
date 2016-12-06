//
//  VideoDetailViewController.m
//  EX-XMHelper
//
//  Created by weiying on 2016/12/6.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoDetailViewController.h"
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
    self.tableView.dataSource = self.dataSource;
}

- (void)setupSignal
{
    //页面显示的的时候请求数据(替换事件响应方法或代理)
    RACSignal *viewAppearSignal = [self rac_signalForSelector:@selector(viewWillAppear:)];
    [viewAppearSignal subscribeNext:^(id x) {
        NSString *urlString = [APIManager api_videoDetailWithVideoType:_type ID:_ID page:1];
        [[self.viewModel.command execute:urlString] subscribeNext:^(NSArray *detailArr) {
            self.dataSource.items = self.viewModel.detailList;
            [self.tableView reloadData];
        }];
    }];
}


#pragma mark - Table view delegate

#pragma mark - lazy loading
- (VideoDetailViewModel *)viewModel
{
    if (!_viewModel) {
        self.viewModel = [[VideoDetailViewModel alloc] init];
    }
    return _viewModel;
}

- (VideoDetailDataSource *)dataSource
{
    if (!_dataSource) {
        self.dataSource = [[VideoDetailDataSource alloc] init];
    }
    return _dataSource;
}

@end
