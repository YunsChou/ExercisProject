//
//  NewsDetailSectionView.m
//  HotLibApp
//
//  Created by weiying on 16/10/20.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "NewsDetailSectionView.h"

@interface NewsDetailSectionView ()
@property (weak, nonatomic) IBOutlet UIView *hotOrRelateBackView;
@property (weak, nonatomic) IBOutlet UIView *moreCommentBackView;

@end

@implementation NewsDetailSectionView

+ (instancetype)sectionHotOrRelateView
{
    return [[NSBundle mainBundle] loadNibNamed:@"NewsDetailSectionView" owner:nil options:nil][0];
}

+ (instancetype)sectionMoreCommentView
{
    return [[NSBundle mainBundle] loadNibNamed:@"NewsDetailSectionView" owner:nil options:nil][1];
}

+ (instancetype)sectionCloseDetailView
{
    return [[NSBundle mainBundle] loadNibNamed:@"NewsDetailSectionView" owner:nil options:nil][2];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.hotOrRelateBackView.layer.borderWidth = 0.5;
    self.hotOrRelateBackView.layer.borderColor = RGB(238, 238, 238).CGColor;
    
    self.moreCommentBackView.layer.borderWidth = 0.5;
    self.moreCommentBackView.layer.borderColor = RGB(238, 238, 238).CGColor;
}

@end
