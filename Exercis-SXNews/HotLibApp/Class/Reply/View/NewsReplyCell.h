//
//  NewsReplyCell.h
//  HotLibApp
//
//  Created by weiying on 16/10/24.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;

@interface NewsReplyCell : UITableViewCell

@property (nonatomic, strong) CommentModel *commentModel;

+ (instancetype)commentCellWithTableView:(UITableView *)tableView;

@end
