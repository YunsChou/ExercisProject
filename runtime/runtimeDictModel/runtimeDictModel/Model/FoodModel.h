//
//  FoodModel.h
//  YsLinkTableView
//
//  Created by weiying on 16/2/14.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Model.h"

@class FoodItemModel;

@interface FoodModel : NSObject <ModelDelegate>
/**分组标题*/
@property (nonatomic, copy) NSString *title;
/**分组中的 食品*/
@property (nonatomic, strong) NSArray<FoodItemModel *> *foodSubs;

@end

@interface FoodItemModel : NSObject
/**菜品id*/
@property (nonatomic, assign) NSInteger foodId;
/**菜品名称*/
@property (nonatomic, copy) NSString *foodName;
/**菜品图片*/
@property (nonatomic, copy) NSString *foodImage;
/**菜品单价*/
@property (nonatomic, assign) double foodPrice;
/**售卖状态 1代表售卖中 0 代表 售卖完*/
@property (nonatomic, assign) NSInteger saleStatus;

/**添加一个字段用来统计单个菜品的选择数量*/
//@property (nonatomic, assign) NSInteger foodCount;

@end
