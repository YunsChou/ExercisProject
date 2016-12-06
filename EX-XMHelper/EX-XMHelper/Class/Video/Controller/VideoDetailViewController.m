//
//  VideoDetailViewController.m
//  EX-XMHelper
//
//  Created by weiying on 2016/12/6.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "VideoDetailViewModel.h"
#import "VideoDetailCell.h"

@interface VideoDetailViewController ()
@property (nonatomic, strong) VideoDetailViewModel *viewModel;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ID;
@end

static NSString * const cellIdentifier = @"VideoDetailCell";

@implementation VideoDetailViewController

#pragma mark - life cycle
- (void)setVideoType:(NSInteger)type name:(NSString *)name ID:(NSString *)ID
{
    _type = type;
    _name = name;
    _ID = ID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //页面显示的的时候请求数据(替换事件响应方法或代理)
    RACSignal *viewAppearSignal = [self rac_signalForSelector:@selector(viewWillAppear:)];
    [viewAppearSignal subscribeNext:^(id x) {
        NSString *urlString = [APIManager api_videoDetailWithVideoType:_type ID:_ID page:1];
        [[self.viewModel.command execute:urlString] subscribeNext:^(NSArray *detailArr) {
            [self.tableView reloadData];
        }];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.detailList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.detailModel = self.viewModel.detailList[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

#pragma mark - lazy loading
- (VideoDetailViewModel *)viewModel
{
    if (!_viewModel) {
        self.viewModel = [[VideoDetailViewModel alloc] init];
    }
    return _viewModel;
}

@end
