//
//  NewsListModel.h
//  HotLibApp
//
//  Created by weiying on 16/9/13.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListModel : NSObject

@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *ename;
@property (nonatomic, copy) NSString *imgsrc;
@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *ptime;

@property (nonatomic, copy) NSString *photosetID;
@property (nonatomic, copy) NSString *template;
@property (nonatomic, assign) NSInteger votecount;
@property (nonatomic, copy) NSString *skipID;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *skipType;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, assign) NSInteger hasAD;

@property (nonatomic, copy) NSString *postid;
@property (nonatomic, assign) BOOL hasCover;
@property (nonatomic, assign) BOOL hasHead;
@property (nonatomic, copy) NSNumber *replyCount;
@property (nonatomic, assign) BOOL hasImg;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, assign) BOOL hasIcon;
@property (nonatomic, copy) NSString *docid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, copy) NSString *lmodify;
@property (nonatomic, copy) NSString *boardid;

@property (nonatomic, strong) NSArray *imgextra;

@end

@interface ImgextraModel : NSObject

@property (nonatomic, copy) NSString *imgsrc;

@end
