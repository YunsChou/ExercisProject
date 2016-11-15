//
//  NewsDetailSectionView.h
//  HotLibApp
//
//  Created by weiying on 16/10/20.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailSectionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *hotOrRelateLabel;

+ (instancetype)sectionHotOrRelateView;
+ (instancetype)sectionMoreCommentView;
+ (instancetype)sectionCloseDetailView;
@end
