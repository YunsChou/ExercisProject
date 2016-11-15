//
//  YsTopScrollView.m
//  ScrollSlideView
//
//  Created by weiying on 16/3/15.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "YsTopScrollView.h"

#define Ys_kTagBase 100

@implementation YsTopScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        _normalFont = [UIFont systemFontOfSize:16];
        _selectFont = [UIFont boldSystemFontOfSize:16];
        _normalColor = [UIColor whiteColor];
        _selectColor = [UIColor redColor];
        _lineViewColor = [UIColor whiteColor];
        _isAVGPage = NO;
        _selectIndex = Ys_kTagBase;
    }
    return self;
}

- (void)setTitleNameArr:(NSArray *)titleNameArr
{
    _titleNameArr = titleNameArr;
    [self setupNameTitle];
    [self setupBottomLine];
}

- (void)setupNameTitle
{
    CGFloat titleScrollW = 0;
    for (NSInteger i = 0; i < _titleNameArr.count; i ++) {
        NSString *titleName = _titleNameArr[i];
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setAttributedTitle:[self titleAttributedWithString:titleName font:_normalFont color:_normalColor] forState:UIControlStateNormal];
        [titleBtn setAttributedTitle:[self titleAttributedWithString:titleName font:_selectFont color:_selectColor] forState:UIControlStateSelected];

        CGFloat titleBtnW = 0;
        if (_isAVGPage) {
            titleBtnW = self.frame.size.width / _titleNameArr.count;
        }else{
            titleBtnW = [self titleWidthWithString:titleName font:titleBtn.titleLabel.font].width + 20;
        }
        titleBtn.frame = CGRectMake(titleScrollW, 0, titleBtnW, self.bounds.size.height);
        titleBtn.tag = i + Ys_kTagBase;
        if (i == 0) {
            titleBtn.selected = YES;
        }
        [titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:titleBtn];
        
        titleScrollW += titleBtnW;
    }
    //顶部不能铺满的情况
    if (titleScrollW < self.frame.size.width) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, titleScrollW, self.frame.size.height);
    }
    self.contentSize = CGSizeMake(titleScrollW, self.bounds.size.height);
}

- (void)setupBottomLine
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = _lineViewColor;
    [self addSubview:lineView];
    self.lineView = lineView;
    [self topContentOffsetWithIndex:0];
}

- (void)setLineViewColor:(UIColor *)lineViewColor
{
    _lineViewColor = lineViewColor;
    self.lineView.backgroundColor = lineViewColor;
}

- (void)topContentOffsetWithIndex:(NSInteger)index
{
    //滚动标题栏
    if ([[self viewWithTag:index + Ys_kTagBase] isKindOfClass:[UIButton class]]) {
        UIButton *titleBtn = (UIButton *)[self viewWithTag:index + Ys_kTagBase];
        [self titleButtonClick:titleBtn];
        //计算标题栏显示
        CGFloat offsetX = titleBtn.center.x - self.frame.size.width / 2;
        CGFloat offsetMax = self.contentSize.width - self.frame.size.width;
        if (offsetX < 0) {
            offsetX = 0;
        }else if (offsetX > offsetMax){
            offsetX = offsetMax;
        }
        CGPoint offset = CGPointMake(offsetX, self.contentOffset.y);
        [self setContentOffset:offset animated:YES];
        //计算标题下标显示
        self.lineView.frame = CGRectMake(titleBtn.frame.origin.x, self.frame.size.height - 2, titleBtn.frame.size.width, 2);
    }
}

#pragma mark - 按钮点击事件
- (void)titleButtonClick:(UIButton *)sender
{
    //更换按钮
    if (sender.tag != _selectIndex) {
        //取消之前的按钮
        UIButton *lastBtn = (UIButton *)[self viewWithTag:_selectIndex];
        lastBtn.selected = NO;
        _selectIndex = sender.tag;
    }
    
    if (!sender.selected) {
        sender.selected = YES;
        //设置rootscroll滚动
        if (_topClickBlock) {
            _topClickBlock(sender.tag - Ys_kTagBase);
        }
    }
}

#pragma mark - 属性设置
- (NSAttributedString *)titleAttributedWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color
{
    NSMutableAttributedString *mAttributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    [mAttributeStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
    [mAttributeStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, string.length)];
    return mAttributeStr;
}

//计算文本的自适应高度
- (CGSize)titleWidthWithString:(NSString *)string font:(UIFont *)font
{
    //设置号文字的属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    //设置好文字的区域范围，最大宽度固定，高度默认无限高
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    //将文字的区域范围传入，选择属性，传入文字的属性
    CGSize realSize = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //取出size返回
    return realSize;
}


@end
