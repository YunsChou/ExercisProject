//
//  VideoDetailDataSource.m
//  EX-XMHelper
//
//  Created by weiying on 2016/12/6.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "VideoDetailDataSource.h"
#import "VideoDetailCell.h"

static NSString * const cellIdentifier = @"VideoDetailCell";

@implementation VideoDetailDataSource

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.detailModel = self.items[indexPath.row];
    return cell;
}

@end
