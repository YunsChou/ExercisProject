//
//  NewsTableController.m
//  HotLibApp
//
//  Created by weiying on 16/9/1.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsTableController.h"
#import "MJRefresh.h"
//Model
//#import "NewsListModel.h"
//View
#import "NormalNewsCell.h"
//ViewModel
#import "NewsListViewModel.h"
//Controller
#import "NewsDetailController.h"
//Tool
#import "HTTPRequestTool.h"

@interface NewsTableController ()
@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, strong) NewsListViewModel *newsViewModel;
@end

@implementation NewsTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupRefresh];
    [self loadLatestData];
}

- (void)setupRefresh
{
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadLatestData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadLatestData
{
    NSString *suffixUrlStr = [NSString stringWithFormat:@"%@/0-20.html", self.urlString];
    [self loadListDataWithUrlStr:suffixUrlStr];
}

- (void)loadMoreData
{

}

- (void)loadListDataWithUrlStr:(NSString *)urlStr
{
    [[self.newsViewModel.fetchListModelCommand execute:urlStr] subscribeNext:^(NSArray *array) {
        [self.newsListArray addObjectsFromArray:array];
        [self.tableView reloadData];
    } error:^(NSError *error) {
         DLog(@"error -- %@",error);
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NormalNewsCell *cell = [NormalNewsCell cellWithTableView:tableView];
    cell.newsListM = self.newsListArray[indexPath.row];
    return cell;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NewsDetailController *detailVC = [[NewsDetailController alloc] init];
    detailVC.listModel = self.newsListArray[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 懒加载
- (NSMutableArray *)newsListArray
{
    if (!_newsListArray) {
        self.newsListArray = [NSMutableArray array];
    }
    return _newsListArray;
}

- (NewsListViewModel *)newsViewModel
{
    if (!_newsViewModel) {
        self.newsViewModel = [[NewsListViewModel alloc] init];
    }
    return _newsViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
