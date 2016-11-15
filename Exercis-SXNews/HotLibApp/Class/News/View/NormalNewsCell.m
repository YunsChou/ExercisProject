//
//  NormalNewsCell.m
//  HotLibApp
//
//  Created by weiying on 16/10/12.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NormalNewsCell.h"
#import "UIImageView+YYWebImage.h"
#import "Masonry.h"
#import "NewsListModel.h"

@interface NormalNewsCell ()
//@property (weak, nonatomic) IBOutlet UILabel *newsTtileLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;

@property (nonatomic, strong) UILabel *newsTitleLabel;
@property (nonatomic, strong) UIImageView *newsImageView;
@property (nonatomic, strong) UILabel *newsSourceLabel;
@property (nonatomic, strong) UILabel *newsCommentsNumLabel;
@end

@implementation NormalNewsCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"NormalNewsCell";
    NormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[NormalNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

//+ (instancetype)cellWithTableView:(UITableView *)tableView
//{
//    static NSString *ID = @"NormalNewsCell";
//    NormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"NormalNewsCell" owner:nil options:nil] firstObject];
//    }
//    return cell;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupSubViews];
        [self mas_layoutSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    UILabel *newsTitleLabel = [[UILabel alloc] init];
    newsTitleLabel.font = [UIFont systemFontOfSize:16];
    newsTitleLabel.numberOfLines = 2;
    [self.contentView addSubview:newsTitleLabel];
    self.newsTitleLabel = newsTitleLabel;
    
    UIImageView *newsImageView = [[UIImageView alloc] init];
    newsImageView.contentMode = UIViewContentModeScaleAspectFill;
    newsImageView.clipsToBounds = YES;
    [self.contentView addSubview:newsImageView];
    self.newsImageView = newsImageView;
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = [UIFont systemFontOfSize:12];
    sourceLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:sourceLabel];
    self.newsSourceLabel = sourceLabel;
    
    UILabel *commentsNumLabel = [[UILabel alloc] init];
    commentsNumLabel.font = [UIFont systemFontOfSize:12];
    commentsNumLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:commentsNumLabel];
    self.newsCommentsNumLabel = commentsNumLabel;
}

- (void)mas_layoutSubViews
{
    CGFloat margin = 8;
    CGFloat padding = 10;
    
    [self.newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(self.contentView).offset(padding);
        make.bottom.equalTo(self.contentView).offset(-padding);
        make.width.mas_equalTo(60);
    }];
    
    [self.newsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.newsImageView.mas_right).offset(margin);
        make.top.equalTo(self.contentView).offset(padding);
        make.right.equalTo(self.contentView).offset(-padding);
    }];
    
    [self.newsSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.newsTitleLabel);
        make.bottom.mas_equalTo(self.newsImageView.mas_bottom);
    }];
    
    [self.newsCommentsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.newsTitleLabel);
        make.bottom.equalTo(self.newsSourceLabel);
    }];
}

- (void)setNewsListM:(NewsListModel *)newsListM
{
    _newsListM = newsListM;
    
    self.newsTitleLabel.text = newsListM.title;
    self.newsSourceLabel.text = newsListM.source;
    CGFloat count =  [newsListM.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    self.newsCommentsNumLabel.text = displayCount;
    [self.newsImageView setImageURL:[NSURL URLWithString:newsListM.imgsrc]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
