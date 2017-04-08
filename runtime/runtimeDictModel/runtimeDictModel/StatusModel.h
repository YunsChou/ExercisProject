//
//  StatusModel.h
//  runtimeDictModel
//
//  Created by weiying on 16/3/18.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Model.h"

@class statusesModel,userModel;

@interface StatusModel : NSObject

@property (nonatomic, strong) NSArray *statuses;

@property (nonatomic, strong) NSArray *ads;

@property (nonatomic, copy) NSString *totalNumber;

@property (nonatomic, copy) NSString *previousCursor;

@property (nonatomic, copy) NSString *nextCursor;

@end
/********************/
@interface statusesModel : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) userModel *user;

@end

@interface userModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *icon;

@end
/********************/
@interface adsModel : NSObject

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *url;

@end
