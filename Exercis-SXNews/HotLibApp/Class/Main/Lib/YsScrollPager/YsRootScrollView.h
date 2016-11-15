//
//  YsRootScrollView.h
//  ScrollSlideView
//
//  Created by weiying on 16/3/15.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YsRootScrollBlock)(NSInteger index, UIViewController *VC, BOOL isExistVC);

@interface YsRootScrollView : UIScrollView<UIScrollViewDelegate>
/**子控制器数组*/
@property (nonatomic, strong) NSArray *contentVCArr;
/**底部滚动事件*/
@property (nonatomic, copy) YsRootScrollBlock rootScrollBlock;
/**底部滚动（若初始化时：需要跳转到指定下标。top和root，调用后创建对象的方法跳转到指定下标）*/
- (void)rootContentOffsetWithIndex:(NSInteger)index;
@end
