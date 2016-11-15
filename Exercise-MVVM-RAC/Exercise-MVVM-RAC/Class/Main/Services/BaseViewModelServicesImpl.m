//
//  BaseViewModelServicesImpl.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseViewModelServicesImpl.h"
#import "RepositoryServiceImpl.h"
#import "AppStoreServiceImpl.h"

@implementation BaseViewModelServicesImpl

@synthesize octClient = _octClient;
@synthesize repositoryService = _repositoryService;
@synthesize appStoreService = _appStoreService;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _repositoryService = [[RepositoryServiceImpl alloc] init];
        _appStoreService = [[AppStoreServiceImpl alloc] init];
    }
    return self;
}

- (void)pushViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated
{
}

- (void)popViewModelAnimated:(BOOL)animated
{
}

- (void)popToRootViewModelWithAnimated:(BOOL)animated
{
}

- (void)presentViewModel:(BaseViewModel *)viewModel animated:(BOOL)animated completion:(VoidBlock)completion
{
}

- (void)dismissViewModelAnimated:(BOOL)animated completion:(VoidBlock)completion
{
}

- (void)resetRootViewModel:(BaseViewModel *)viewModel
{
}

@end
