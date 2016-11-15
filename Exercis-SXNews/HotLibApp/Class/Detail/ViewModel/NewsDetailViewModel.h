//
//  NewsDetailViewModel.h
//  HotLibApp
//
//  Created by weiying on 16/10/18.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsDetailModel.h"

@class NewsListModel;

@interface NewsDetailViewModel : NSObject

@property (nonatomic, strong) NewsListModel *listModel;
@property (nonatomic, strong) NewsDetailModel *detailModel;

@property (nonatomic, strong) RACCommand *fetchDetailModelCommand;
//@property (nonatomic, strong) RACCommand *fetchHotReplyModelCommand;
@end
