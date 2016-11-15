//
//  NewsDetailDataSource.h
//  HotLibApp
//
//  Created by weiying on 16/10/21.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsDetailViewModel;
@class CommentViewModel;

@interface NewsDetailDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) NewsDetailViewModel *detailViewModel;

@property (nonatomic, strong) CommentViewModel *commentViewModel;
@end
