//
//  VideoListViewController.m
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoListViewModel.h"
#import "VideoListCell.h"
#import "VideoDetailViewController.h"

@interface VideoListViewController ()<UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UISegmentedControl *videoTypeSegment;
@property (nonatomic, strong) VideoListViewModel *viewModel;
@end

static NSString * const reuseIdentifier = @"VideoListCell";

@implementation VideoListViewController

//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.hidesBottomBarWhenPushed = NO;
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.hidesBottomBarWhenPushed = YES;
//};

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.hidesBottomBarWhenPushed = YES;
    
    [self setupSignal];
}

- (void)setupSignal
{
    
    @weakify(self);
    
    //页面显示的的时候请求数据(替换事件响应方法或代理)
    RACSignal *viewAppearSignal = [self rac_signalForSelector:@selector(viewWillAppear:)];
    [[[[RACSignal merge:@[viewAppearSignal]] flattenMap:^RACStream *(id value) {
        @strongify(self);
        return [self.viewModel refreshObjectWithErrorHandler:^{
            
        }];
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self.collectionView reloadData];
    }];
    
    //点击segment请求数据(监听事件)
    [[[[self.videoTypeSegment rac_signalForControlEvents:UIControlEventValueChanged] flattenMap:^RACStream *(id value) {
        return [self.viewModel refreshObjectWithErrorHandler:^{
            
        }];
    }] deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        @strongify(self);
        [self.collectionView reloadData];
    }];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.videoList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.videoModel = self.viewModel.videoList[indexPath.row];
    // Configure the cell
//    RAC(cell, model) = self.viewModel.videoList;
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100, 120);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //sender为（点击等）动作对象
    VideoListCell *cell = (VideoListCell *)sender;
    //push动作的identifier
    if ([segue.identifier isEqualToString:@"VideoDetail"]) {
        //目标控制器
        VideoDetailViewController *videoDetailVC = segue.destinationViewController;
        [videoDetailVC setVideoType:self.viewModel.type name:cell.videoModel.name ID:cell.videoModel.itemID];
    }
}

#pragma mark - lazy load
- (VideoListViewModel *)viewModel
{
    if (!_viewModel) {
        VideoListViewModel *viewModel = [[VideoListViewModel alloc] init];
        RAC(viewModel, segmentType) = [self.videoTypeSegment rac_newSelectedSegmentIndexChannelWithNilValue:nil];
        self.viewModel = viewModel;
    }
    return _viewModel;
}

@end
