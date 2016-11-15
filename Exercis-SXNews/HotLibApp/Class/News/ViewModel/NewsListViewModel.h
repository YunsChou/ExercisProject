//
//  NewsListViewModel.h
//  HotLibApp
//
//  Created by weiying on 16/9/13.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListViewModel : NSObject

@property (nonatomic, strong) RACCommand *fetchListModelCommand;

@end
