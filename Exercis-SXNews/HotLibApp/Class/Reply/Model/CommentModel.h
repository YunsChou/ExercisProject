//
//  HotCommentModel.h
//  HotLibApp
//
//  Created by weiying on 16/10/20.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject
/** 用户头像*/
@property(nonatomic, copy) NSString *timg;
/** 用户地址*/
@property(nonatomic, copy) NSString *f;
/** 实际评价*/
@property(nonatomic, copy) NSString *b;
/** 用户名称*/
@property(nonatomic, copy) NSString *n;
/** 顶帖人数*/
@property(nonatomic, copy) NSString *v;
@end
