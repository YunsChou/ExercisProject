//
//  QuestUseController.m
//  runtimeSwizzleDemo
//
//  Created by weiying on 16/5/19.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "QuestUseController.h"
#import <objc/runtime.h>

#import "UIButton+Count.h"
#import "MethodTool.h"

@interface QuestUseController ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property (weak, nonatomic) IBOutlet UIButton *currentSelBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentSelLabel;

@end

@implementation QuestUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    //每次进来都交换方法
    //注意：这种做法是不科学的，真正的需求通常是，期望该方法在整个应用中只交换一次
    [self exchangeSel];
}

- (IBAction)currentSelBtnClick:(id)sender {
    self.currentSelLabel.text = [self firstMethod];
}

- (void)exchangeSel
{
    //获取两个方法
    Method m1 = class_getInstanceMethod([self class], @selector(firstMethod));
    Method m2 = class_getInstanceMethod([self class], @selector(secondMethod));
    //交换两个方法
    method_exchangeImplementations(m1, m2);
}

- (NSString *)firstMethod
{
    return @"我是方法 1 -- ";
}

- (NSString *)secondMethod
{
    return @"我是方法 2 -- ";
}


- (IBAction)countBtnClick:(id)sender {
    [[MethodTool shareMethodTool] addCount];
    self.countLabel.text = [NSString stringWithFormat:@"%ld",[MethodTool shareMethodTool].countNum];
}





@end
