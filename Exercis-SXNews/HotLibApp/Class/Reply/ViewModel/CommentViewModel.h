//
//  HotCommentViewModel.h
//  HotLibApp
//
//  Created by weiying on 16/10/20.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@class NewsListModel;

@interface CommentViewModel : NSObject

@property (nonatomic, strong) NewsListModel *listModel;
@property (nonatomic, strong) NSArray *hotCommentModels;
@property (nonatomic, strong) NSArray *normalCommentModels;

@property (nonatomic, strong) RACCommand *fetchHotCommentModelCommand;
@property (nonatomic, strong) RACCommand *fetchNormalCommentModelCommand;
@end
