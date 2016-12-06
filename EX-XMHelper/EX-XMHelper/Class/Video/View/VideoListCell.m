//
//  VideoListCell.m
//  EX-XMHelper
//
//  Created by weiying on 2016/12/6.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoListCell.h"
#import "UIImageView+WebCache.h"
//#import "VideoListModel.h"

@interface VideoListCell ()
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end

@implementation VideoListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setupSignal
{
    @weakify(self);
    [RACObserve(self, videoModel) subscribeNext:^(VideoListModel *videoModel) {
        @strongify(self);
        self.nameLabel.text = videoModel.name;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.img]];
    }];
}

- (void)setVideoModel:(VideoListModel *)videoModel
{
    _videoModel = videoModel;
    self.nameLabel.text = videoModel.name;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:videoModel.img]];
}

@end
