//
//  BaseViewModelServices.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/10.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNavigationProtocol.h"
#import "RepositoryService.h"
#import "AppStoreService.h"

@protocol BaseViewModelServices <NSObject, BaseNavigationProtocol>

@property (nonatomic, strong) OCTClient *octClient;

@property (nonatomic, strong, readonly) id<RepositoryService> repositoryService;
@property (nonatomic, strong, readonly) id<AppStoreService> appStoreService;
@end
