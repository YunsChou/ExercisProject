//
//  VideoListViewController.m
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoListViewModel.h"
#import "VideoListCollectionViewCell.h"

@interface VideoListViewController ()<UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UISegmentedControl *videoTypeSegment;
@property (nonatomic, strong) VideoListViewModel *viewModel;
@end

static NSString * const reuseIdentifier = @"VideoListCell";

@implementation VideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[VideoListViewModel alloc] init];
    
    RAC(self.viewModel, segmentType) = [self.videoTypeSegment rac_newSelectedSegmentIndexChannelWithNilValue:nil];
    
    @weakify(self);
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
    VideoListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
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


@end
