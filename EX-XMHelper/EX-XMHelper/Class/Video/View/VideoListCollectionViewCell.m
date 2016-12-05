//
//  VideoListCollectionViewCell.m
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoListCollectionViewCell.h"

#import "VideoListViewModel.h"

@interface VideoListCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation VideoListCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

//- (void)setupSignal
//{
//    @weakify(self);
//    [RACObserve(self, viewModel) subscribeNext:^(VideoListViewModel *viewModel) {
//        @strongify(self);
//        self.nameLabel.text = viewModel.
//    }];
//}

@end
