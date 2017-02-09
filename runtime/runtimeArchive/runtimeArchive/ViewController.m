//
//  ViewController.m
//  runtimeArchive
//
//  Created by weiying on 16/3/18.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "ViewController.h"
#import "ArchiveModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ArchiveModel *archiveM = [[ArchiveModel alloc] init];
    archiveM.abc = @"ahah";
    archiveM.def = @"eheh";
    archiveM.ghi = @"uhuh";
    //归档模型数据转为二进制
    NSData *archiveData = [NSKeyedArchiver archivedDataWithRootObject:archiveM];
    //解归档二进制数据为模型
    ArchiveModel *unArchiveM = [NSKeyedUnarchiver unarchiveObjectWithData:archiveData];
    
    NSLog(@"unArchiveM.abc -- %@",unArchiveM.abc);
    NSLog(@"unArchiveM.def -- %@",unArchiveM.def);
    NSLog(@"unArchiveM.ghi -- %@",unArchiveM.ghi);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
