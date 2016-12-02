//
//  HomepageViewController.m
//  Exercise-MVVM-RAC
//
//  Created by Yuns on 2016/12/1.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "HomepageViewController.h"
#import "BaseNavigationController.h"
#import "HomePageViewModel.h"
#import "NewsViewModel.h"
#import "NewsViewController.h"
#import "ReposViewModel.h"
#import "ReposViewController.h"
#import "ExploreViewModel.h"
#import "ExploreViewController.h"
#import "ProfileViewModel.h"
#import "ProfileViewController.h"

@interface HomepageViewController ()
@property (nonatomic, strong)  HomePageViewModel*viewModel;
@end

@implementation HomepageViewController

@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    NewsViewController *newsViewController = [[NewsViewController alloc] initWithViewModel:self.viewModel.newsViewModel];
    newsViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"News" image:[UIImage new] selectedImage:[UIImage new]];
    BaseNavigationController *newsNavigationController =[[BaseNavigationController alloc] initWithRootViewController:newsViewController];
    
    ReposViewController *reposViewController = [[ReposViewController alloc] initWithViewModel:self.viewModel.reposViewModel];
    reposViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Reposity" image:[UIImage new] selectedImage:[UIImage new]];
    BaseNavigationController *reposNavigationController =[[BaseNavigationController alloc] initWithRootViewController:reposViewController];
    
    ExploreViewController *exploreViewController = [[ExploreViewController alloc] initWithViewModel:self.viewModel.exploreViewModel];
    exploreViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Explore" image:[UIImage new] selectedImage:[UIImage new]];
    BaseNavigationController *exploreNavigationController =[[BaseNavigationController alloc] initWithRootViewController:exploreViewController];
    
    ProfileViewController *profileViewController = [[ProfileViewController alloc] initWithViewModel:self.viewModel.profileViewModel];
    profileViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage new] selectedImage:[UIImage new]];
    BaseNavigationController *profileNavigationController =[[BaseNavigationController alloc] initWithRootViewController:profileViewController];
    
    self.tabBarController.viewControllers = @[newsNavigationController, reposNavigationController, exploreNavigationController, profileNavigationController];
    
    [ShareAppDelegate.navigationControllerStack pushNavigationController:newsNavigationController];
    [[self rac_signalForSelector:@selector(tabBarController:didSelectViewController:) fromProtocol:@protocol(UITabBarControllerDelegate)] subscribeNext:^(RACTuple *tuple) {
        [ShareAppDelegate.navigationControllerStack popNavigationController];
        [ShareAppDelegate.navigationControllerStack pushNavigationController:tuple.second];
    }];
    self.tabBarController.delegate = self;
}



@end
