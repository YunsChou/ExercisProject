//
//  HomePageViewModel.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "BaseViewModel.h"
#import "NewsViewModel.h"
#import "ReposViewModel.h"
#import "ExploreViewModel.h"
#import "ProfileViewModel.h"

@interface HomePageViewModel : BaseViewModel

@property (nonatomic, strong, readonly) NewsViewModel *newsViewModel;

@property (nonatomic, strong, readonly) ReposViewModel *reposViewModel;

@property (nonatomic, strong, readonly) ExploreViewModel *exploreViewModel;

@property (nonatomic, strong, readonly) ProfileViewModel *profileViewModel;

@end
