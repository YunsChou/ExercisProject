//
//  NewsReplyCell.m
//  HotLibApp
//
//  Created by weiying on 16/10/24.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsReplyCell.h"
#import "UIImageView+YYWebImage.h"
#import "CommentModel.h"

@interface NewsReplyCell ()
@property (weak, nonatomic) IBOutlet UIImageView *commentUserAvtar;
@property (weak, nonatomic) IBOutlet UILabel *commentUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentUserAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentPariseNumLabel;
@end

@implementation NewsReplyCell

//XIB的cell
+ (instancetype)commentCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"replyCell";
    NewsReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NewsReplyCell" owner:nil options:nil] firstObject];
    }
    return cell;
}


- (void)setCommentModel:(CommentModel *)commentModel
{
    _commentModel = commentModel;
    self.commentUserNameLabel.text = commentModel.n;
    self.commentUserAddressLabel.text = commentModel.f;
    self.commentContentLabel.text = commentModel.b;
    
    [self.commentUserAvtar setImageURL:[NSURL URLWithString:commentModel.timg]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
