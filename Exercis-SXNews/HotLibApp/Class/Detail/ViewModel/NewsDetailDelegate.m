//
//  NewsDetailDelegate.m
//  HotLibApp
//
//  Created by weiying on 16/10/21.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsDetailDelegate.h"
#import "NewsDetailViewModel.h"
#import "CommentViewModel.h"
#import "NewsDetailSectionView.h"

#import "NewsDetailCell.h"

@interface NewsDetailDelegate ()
@property (nonatomic, copy) NewsDetailCellSelectedBlock selectedBlock;
@property (nonatomic, copy) NewsDetailEndDragCloseBlock closeBlock;
@end

@implementation NewsDetailDelegate

- (void)setDetailViewModel:(NewsDetailViewModel *)detailViewModel
{
    _detailViewModel = detailViewModel;
}

- (void)setCommentViewModel:(CommentViewModel *)commentViewModel
{
    _commentViewModel = commentViewModel;
}

- (void)setWebView:(UIWebView *)webView
{
    _webView = webView;
}

- (void)newsDetailCellSelectedBlock:(NewsDetailCellSelectedBlock)selectedBlock
{
    self.selectedBlock = selectedBlock;
}

- (void)newsDetailEndDragCloseBlock:(NewsDetailEndDragCloseBlock)closeBlock
{
    self.closeBlock = closeBlock;
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return 126;
    }else if (1 == indexPath.section){
        if (self.commentViewModel.hotCommentModels.count == indexPath.row) {
            return 40;
        }else{
            return 110;
        }
    }else if (2 == indexPath.section){
        return 80;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.webView.height;
    }else if (1 == section){
        return 40;
    }else if (2 == section){
        return 40;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (2 == section) {
        return 64;
    }
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (0 == section) {
        return self.webView;
    }else if (1 == section){
        NewsDetailSectionView *hotHeader = [NewsDetailSectionView sectionHotOrRelateView];
        hotHeader.hotOrRelateLabel.text = @"热门跟帖";
        return hotHeader;
    }else if (2 == section){
        NewsDetailSectionView *relateHeader = [NewsDetailSectionView sectionHotOrRelateView];
        relateHeader.hotOrRelateLabel.text = @"相关新闻";
        return relateHeader;
    }
    return [[UIView alloc] init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (2 == section) {
        NewsDetailSectionView *closeFooter = [NewsDetailSectionView sectionCloseDetailView];
        return closeFooter;
    }
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedBlock) {
        self.selectedBlock(indexPath);
    }
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    BOOL isDetailClose = (scrollView.contentOffset.y - (scrollView.contentSize.height - SCREEN_HEIGHT + 55)) > (100 - 54);
    if (isDetailClose) {
        DLog(@"关闭详情 -- ");
        if (self.closeBlock) {
            self.closeBlock();
        }
    }
}

@end
