//
//  NormalNewsCell.h
//  HotLibApp
//
//  Created by weiying on 16/10/12.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsListModel;

@interface NormalNewsCell : UITableViewCell

@property (nonatomic, strong) NewsListModel *newsListM;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
