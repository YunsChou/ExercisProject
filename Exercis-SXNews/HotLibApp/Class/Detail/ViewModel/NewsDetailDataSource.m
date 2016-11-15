//
//  NewsDetailDataSource.m
//  HotLibApp
//
//  Created by weiying on 16/10/21.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsDetailDataSource.h"
#import "NewsDetailCell.h"
#import "NewsDetailViewModel.h"
#import "CommentViewModel.h"

@implementation NewsDetailDataSource

- (void)setDetailViewModel:(NewsDetailViewModel *)detailViewModel
{
    _detailViewModel = detailViewModel;
}

- (void)setCommentViewModel:(CommentViewModel *)commentViewModel
{
    _commentViewModel = commentViewModel;
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    }else if (1 == section){
        return self.commentViewModel.hotCommentModels.count + 1;
    }else if (2 == section){
        return self.detailViewModel.detailModel.relative_sys.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0 == indexPath.section) {
        NewsDetailCell *detailShareCell = [NewsDetailCell detailShareCellWithTableView:tableView];
        return detailShareCell;
    }else if (1 == indexPath.section){
        if (self.commentViewModel.hotCommentModels.count == indexPath.row) {
            NewsDetailCell *moreCommentCell = [NewsDetailCell moreCommentCellWithTableView:tableView];
            return moreCommentCell;
        }else{
            NewsDetailCell *hotCommentCell = [NewsDetailCell hotCommentCellWithTableView:tableView];
            hotCommentCell.commentModel = self.commentViewModel.hotCommentModels[indexPath.row];
            return hotCommentCell;
        }
    }else if (2 == indexPath.section){
        NewsDetailCell *relateNewsCell = [NewsDetailCell relateNewsCellWithTableView:tableView];
        relateNewsCell.relateNewsModel = self.detailViewModel.detailModel.relative_sys[indexPath.row];
        return relateNewsCell;
    }
    return nil;
}

@end
