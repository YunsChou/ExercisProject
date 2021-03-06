//
//  VideoDetailViewModel.h
//  EX-XMHelper
//
//  Created by weiying on 2016/12/6.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIManager.h"

@interface VideoDetailViewModel : NSObject

//@property (nonatomic, strong) RACCommand *command;

@property (nonatomic, strong, readonly) NSMutableArray *detailList;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, assign) NSInteger type;

- (RACSignal *)fetchLatestObjects;

- (RACSignal *)fetchMoreObjects;

@end
