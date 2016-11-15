//
//  NewsDetailDelegate.h
//  HotLibApp
//
//  Created by weiying on 16/10/21.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsDetailViewModel;
@class CommentViewModel;

typedef void (^NewsDetailCellSelectedBlock)(NSIndexPath *indexPath);
typedef void (^NewsDetailEndDragCloseBlock)();

@interface NewsDetailDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, strong) NewsDetailViewModel *detailViewModel;

@property (nonatomic, strong) CommentViewModel *commentViewModel;

@property (nonatomic, strong) UIWebView *webView;

- (void)newsDetailCellSelectedBlock:(NewsDetailCellSelectedBlock)selectedBlock;
- (void)newsDetailEndDragCloseBlock:(NewsDetailEndDragCloseBlock)closeBlock;
@end
