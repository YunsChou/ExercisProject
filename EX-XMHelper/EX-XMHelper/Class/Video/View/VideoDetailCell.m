//
//  VideoDetailCell.m
//  EX-XMHelper
//
//  Created by weiying on 2016/12/6.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoDetailCell.h"
#import "UIImageView+WebCache.h"
#import "VideoDetailModel.h"

@interface VideoDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lenghtTimeLabel;

@end

@implementation VideoDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDetailModel:(VideoDetailModel *)detailModel
{
    _detailModel = detailModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.img]];
    self.itemTitleLabel.text = detailModel.name;
}

@end
