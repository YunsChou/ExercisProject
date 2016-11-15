//
//  NewsDetailModel.h
//  HotLibApp
//
//  Created by weiying on 16/10/19.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RelateNewsModel;

@interface NewsDetailModel : NSObject
/** 新闻标题 */
@property (nonatomic, copy) NSString *title;
/** 新闻发布时间 */
@property (nonatomic, copy) NSString *ptime;
/** 新闻内容 */
@property (nonatomic, copy) NSString *body;
/** 新闻配图*/
@property (nonatomic, strong) NSArray *img;
/** 相关新闻*/
@property (nonatomic, strong) NSArray *relative_sys;
@end

@interface RelateNewsModel : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *source;

@property(nonatomic,copy)NSString *imgsrc;

@property(nonatomic,copy)NSString *ptime;

@property(nonatomic,copy)NSString *newsID;

@end
