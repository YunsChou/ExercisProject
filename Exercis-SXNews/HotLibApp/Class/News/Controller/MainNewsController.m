//
//  MainNewsController.m
//  HotLibApp
//
//  Created by weiying on 16/9/13.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "MainNewsController.h"
#import "YsTopScrollView.h"
#import "YsRootScrollView.h"
#import "NewsTableController.h"

@interface MainNewsController ()
@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, strong) YsTopScrollView *topScrollView;
@property (nonatomic, strong) YsRootScrollView *rootScrollView;
@end

@implementation MainNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setupTopAndRootScrollView];
}

- (void)setupTopAndRootScrollView
{
    //数据处理
    NSMutableArray *titleArr = [NSMutableArray array];
    NSMutableArray *subVcArr = [NSMutableArray array];
    for (NSDictionary *itemDict in self.itemArr) {
        [titleArr addObject:itemDict[@"title"]];
        NewsTableController *newsVC = [[NewsTableController alloc] init];
        newsVC.urlString = itemDict[@"urlString"];
        [self addChildViewController:newsVC];
        [subVcArr addObject:newsVC];
    }
    
    //添加控件
    YsTopScrollView *topScrollView = [[YsTopScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    topScrollView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    topScrollView.normalColor = [UIColor blackColor];
    topScrollView.lineViewColor = [UIColor redColor];
    topScrollView.topClickBlock = ^(NSInteger index){
        [self.rootScrollView rootContentOffsetWithIndex:index];
    };
    topScrollView.titleNameArr = titleArr;
    [self.view addSubview:topScrollView];
    self.topScrollView = topScrollView;
    
    YsRootScrollView *rootScrollView = [[YsRootScrollView alloc] initWithFrame:CGRectMake(0, 64 + 40, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40)];
    rootScrollView.rootScrollBlock = ^(NSInteger index, UIViewController *VC, BOOL isExistVC){
        [self.topScrollView topContentOffsetWithIndex:index];
    };
    rootScrollView.contentVCArr = subVcArr;
    [self.view addSubview:rootScrollView];
    self.rootScrollView = rootScrollView;
}

#pragma mark - 懒加载
- (NSArray *)itemArr
{
    if (!_itemArr) {
        _itemArr = @[
                      @{@"title" : @"头条", @"urlString" : @"headline/T1348647853363"},
                      @{@"title" : @"NBA", @"urlString" : @"list/T1348649145984"},
                      @{@"title" : @"手机", @"urlString" : @"list/T1348649654285"},
                      @{@"title" : @"移动互联", @"urlString" : @"list/T1351233117091"},
                      @{@"title" : @"娱乐", @"urlString" : @"list/T1348648517839"},
                      @{@"title" : @"时尚", @"urlString" : @"list/T1348650593803"},
                      @{@"title" : @"电影", @"urlString" : @"list/T1348648650048"},
                      @{@"title" : @"科技", @"urlString" : @"list/T1348649580692"}];
    }
    return _itemArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
