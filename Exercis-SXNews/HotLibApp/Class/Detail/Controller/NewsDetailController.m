//
//  NewsDetailController.m
//  HotLibApp
//
//  Created by weiying on 16/10/18.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsDetailController.h"
//View
#import "NewsDetailSectionView.h"
//ViewModel
#import "NewsDetailViewModel.h"
#import "CommentViewModel.h"
#import "NewsDetailDataSource.h"
#import "NewsDetailDelegate.h"
//Controller
#import "NewsReplyController.h"

@interface NewsDetailController ()<UIWebViewDelegate>
@property (nonatomic, strong) NewsDetailViewModel *detailViewModel;
@property (nonatomic, strong) CommentViewModel *commentViewModel;
@property (nonatomic, strong) NewsDetailDataSource *detailDataSource;
@property (nonatomic, strong) NewsDetailDelegate *detailDelegate;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation NewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupTableView];
    [self requestDetailData];
    [self requestCommentData];
}

#pragma mark - 初始化控件
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 24) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = RGB(246, 246, 246);
    tableView.delegate = self.detailDelegate;
    tableView.dataSource = self.detailDataSource;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - 请求详情数据
- (void)requestDetailData
{
    RAC(self.detailViewModel, listModel) = RACObserve(self, listModel);
    [[self.detailViewModel.fetchDetailModelCommand execute:nil] subscribeError:^(NSError *error) {
        DLog(@"error -- %@", error);
    } completed:^{
        DLog(@"title -- %@", self.detailViewModel.detailModel.title);
        [self loadWebViewContent];
    }];
}

- (void)requestCommentData
{
    RAC(self.commentViewModel, listModel) = RACObserve(self, listModel);
    [[self.commentViewModel.fetchHotCommentModelCommand execute:nil] subscribeCompleted:^{
        self.detailDelegate.webView = self.webView;
        self.detailDelegate.commentViewModel = self.commentViewModel;
        self.detailDataSource.commentViewModel = self.commentViewModel;
        [self.tableView reloadData];
    }];
}

#pragma mark - loadWebView
- (void)loadWebViewContent
{
    [self.webView loadHTMLString:self.detailViewModel.detailModel.body baseURL:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#F6F6F6'"];
    self.webView.height = webView.scrollView.contentSize.height;
    
    self.detailDelegate.webView = self.webView;
    self.detailDelegate.detailViewModel = self.detailViewModel;
    self.detailDataSource.detailViewModel = self.detailViewModel;
    [self.tableView reloadData];
}

#pragma mark - 截屏
- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT), NO, 1.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 懒加载
- (NewsDetailViewModel *)detailViewModel
{
    if (!_detailViewModel) {
        self.detailViewModel = [[NewsDetailViewModel alloc] init];
    }
    return _detailViewModel;
}

- (CommentViewModel *)commentViewModel
{
    if (!_commentViewModel) {
        self.commentViewModel = [[CommentViewModel alloc] init];
    }
    return _commentViewModel;
}

- (NewsDetailDelegate *)detailDelegate
{
    if (!_detailDelegate) {
        self.detailDelegate = [[NewsDetailDelegate alloc] init];
        [self.detailDelegate newsDetailCellSelectedBlock:^(NSIndexPath *indexPath) {
            if (1 == indexPath.section) {
                if (self.commentViewModel.hotCommentModels.count == indexPath.row) {
                    NewsReplyController *replyVC = [[NewsReplyController alloc] init];
                    replyVC.listModel = self.listModel;
                    [self.navigationController pushViewController:replyVC animated:YES];
                }
            }else if (2 == indexPath.section){
                //获取新闻ID进行跳转
            }
        }];
        
        [self.detailDelegate newsDetailEndDragCloseBlock:^{
            //获取当前截图
            UIImageView *screenshots = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            screenshots.image = [self screenshot];
            
            UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
            [keyWindow addSubview:screenshots];
            
            [self.navigationController popViewControllerAnimated:NO];
            screenshots.alpha = 1.0;
            [UIView animateWithDuration:0.3 animations:^{
                screenshots.frame = CGRectMake(0, SCREEN_HEIGHT / 2, SCREEN_WIDTH, 0);
                screenshots.alpha = 0.0;
            } completion:^(BOOL finished) {
                [screenshots removeFromSuperview];
            }];
        }];
    }
    return _detailDelegate;
}

- (NewsDetailDataSource *)detailDataSource
{
    if (!_detailDataSource) {
        self.detailDataSource = [[NewsDetailDataSource alloc] init];
    }
    return _detailDataSource;
}

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        webView.delegate = self;
        self.webView = webView;
    }
    return _webView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
