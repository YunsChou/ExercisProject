//
//  VideoListModel.h
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoListModel : NSObject

@property (nonatomic, copy) NSString *itemID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger count;

@end
