//
//  NewsReplyController.m
//  HotLibApp
//
//  Created by weiying on 16/10/24.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsReplyController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "NewsListModel.h"
#import "CommentViewModel.h"
#import "NewsReplyCell.h"
#import "NewsReplyHeader.h"

static NSString * const cellID = @"replyCell";

@interface NewsReplyController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CommentViewModel *commentViewModel;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation NewsReplyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self requestCommentData];
}

#pragma mark - 初始化控件
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    //XIB的cell
    [tableView registerNib:[UINib nibWithNibName:@"NewsReplyCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - 请求网络数据
- (void)requestCommentData
{
    RAC(self.commentViewModel, listModel) = RACObserve(self, listModel);
    [[self.commentViewModel.fetchHotCommentModelCommand execute:nil] subscribeCompleted:^{
        [self.tableView reloadData];
    }];
    [[self.commentViewModel.fetchNormalCommentModelCommand execute:nil] subscribeCompleted:^{
        [self.tableView reloadData];
    }];
}

#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == self.commentViewModel.hotCommentModels.count) {//如果连热门评论都没有，说明也没有普通评论
        return 1;
    }else{
        if (0 == section) {
            return self.commentViewModel.hotCommentModels.count;
        }else{
            return self.commentViewModel.normalCommentModels.count;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == self.commentViewModel.hotCommentModels.count) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"    评论加载中...";
        return cell;
    }else{
        NewsReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == self.commentViewModel.hotCommentModels.count) {
        return 40;
    }else{
        CGFloat cellHeight = [tableView fd_heightForCellWithIdentifier:cellID configuration:^(NewsReplyCell *cell) {
            [self configureCell:cell atIndexPath:indexPath];
        }];
        return cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return [NewsReplyHeader newsHotReplyHeader];
    }else{
        return [NewsReplyHeader newsNormalReplyHeader];
    }
}

- (void)configureCell:(NewsReplyCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
//    cell.fd_enforceFrameLayout = NO;
    if (0 == indexPath.section) {
        cell.commentModel = self.commentViewModel.hotCommentModels[indexPath.row];
    }else{
        cell.commentModel = self.commentViewModel.normalCommentModels[indexPath.row];
    }
}

#pragma mark - 懒加载
- (CommentViewModel *)commentViewModel
{
    if (!_commentViewModel) {
        self.commentViewModel = [[CommentViewModel alloc] init];
    }
    return _commentViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
