//
//  NewsDetailCell.m
//  HotLibApp
//
//  Created by weiying on 16/10/20.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsDetailCell.h"
#import "UIImageView+YYWebImage.h"
#import "CommentModel.h"
#import "NewsDetailModel.h"

@interface NewsDetailCell ()
@property (weak, nonatomic) IBOutlet UIView *hotCommentBackView;
@property (weak, nonatomic) IBOutlet UIView *relateNewsBackView;
@property (weak, nonatomic) IBOutlet UIView *moreCommentBackView;

//热门评论
@property (weak, nonatomic) IBOutlet UIImageView *commentUserAvtar;
@property (weak, nonatomic) IBOutlet UILabel *commentUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentUserAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentPariseNumLabel;

//相关新闻
@property (weak, nonatomic) IBOutlet UIImageView *relateNewsImageView;
@property (weak, nonatomic) IBOutlet UILabel *relateNewsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *relateNewsSourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *relateNewsTimeLabel;

@end

@implementation NewsDetailCell

+ (instancetype)detailShareCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"detailShareCell";
    NewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsDetailCell" owner:nil options:nil][0];
    }
    return cell;
}

+ (instancetype)hotCommentCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"hotCommentCell";
    NewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsDetailCell" owner:nil options:nil][1];
    }
    return cell;
}

+ (instancetype)moreCommentCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"moreCommentCell";
    NewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsDetailCell" owner:nil options:nil][2];
    }
    return cell;
}

+ (instancetype)relateNewsCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"relateNewsCell";
    NewsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NewsDetailCell" owner:self options:nil][3];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.hotCommentBackView.layer.borderWidth = 0.5;
    self.hotCommentBackView.layer.borderColor = RGB(238, 238, 238).CGColor;
    self.relateNewsBackView.layer.borderWidth = 0.5;
    self.relateNewsBackView.layer.borderColor = RGB(238, 238, 238).CGColor;
    self.moreCommentBackView.layer.borderWidth = 0.5;
    self.moreCommentBackView.layer.borderColor = RGB(238, 238, 238).CGColor;
}

#pragma mark - 数据
- (void)setCommentModel:(CommentModel *)commentModel
{
    _commentModel = commentModel;
    self.commentUserNameLabel.text = commentModel.n;
    self.commentUserAddressLabel.text = commentModel.f;
    self.commentContentLabel.text = commentModel.b;
    self.commentPariseNumLabel.text = [NSString stringWithFormat:@"%@ 顶", commentModel.v];
    
    [self.commentUserAvtar setImageURL:[NSURL URLWithString:commentModel.timg]];
}

- (void)setRelateNewsModel:(RelateNewsModel *)relateNewsModel
{
    _relateNewsModel = relateNewsModel;
    self.relateNewsTitleLabel.text = relateNewsModel.title;
    self.relateNewsSourceLabel.text = relateNewsModel.source;
    self.relateNewsTimeLabel.text = relateNewsModel.ptime;
    
    [self.relateNewsImageView setImageURL:[NSURL URLWithString:relateNewsModel.imgsrc]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
