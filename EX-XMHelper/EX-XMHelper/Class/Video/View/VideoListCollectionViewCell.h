//
//  VideoListCollectionViewCell.h
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideoListViewModel;

@interface VideoListCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) VideoListViewModel *viewModel;

@end
