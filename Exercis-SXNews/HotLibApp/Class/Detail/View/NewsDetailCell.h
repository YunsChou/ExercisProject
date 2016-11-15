//
//  NewsDetailCell.h
//  HotLibApp
//
//  Created by weiying on 16/10/20.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;
@class RelateNewsModel;

@interface NewsDetailCell : UITableViewCell

@property (nonatomic, strong) CommentModel *commentModel;
@property (nonatomic, strong) RelateNewsModel *relateNewsModel;

+ (instancetype)detailShareCellWithTableView:(UITableView *)tableView;

+ (instancetype)hotCommentCellWithTableView:(UITableView *)tableView;

+ (instancetype)moreCommentCellWithTableView:(UITableView *)tableView;

+ (instancetype)relateNewsCellWithTableView:(UITableView *)tableView;

@end
