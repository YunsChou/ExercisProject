//
//  HomePageViewModel.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "HomePageViewModel.h"

@interface HomePageViewModel ()
@property (nonatomic, strong, readwrite) NewsViewModel *newsViewModel;
@property (nonatomic, strong, readwrite) ExploreViewModel *exploreViewModel;
@property (nonatomic, strong, readwrite) ProfileViewModel *profileViewModel;
@end

@implementation HomePageViewModel

- (void)initialize
{
    [super initialize];
    
    self.newsViewModel = [[NewsViewModel alloc] initWithServices:self.services params:nil];
    self.exploreViewModel = [[ExploreViewModel alloc] initWithServices:self.services params:nil];
    self.profileViewModel = [[ProfileViewModel alloc] initWithServices:self.services params:nil];
}

@end
