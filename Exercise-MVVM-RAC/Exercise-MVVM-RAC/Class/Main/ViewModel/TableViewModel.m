//
//  TableViewModel.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "TableViewModel.h"

@interface TableViewModel ()
@property (nonatomic, strong, readwrite) RACCommand *requetRemoteDataCommand;
@end

@implementation TableViewModel

- (void)initialize
{
    [super initialize];
    
    self.page = 1;
    self.limit = 100;
    
    @weakify(self);
    self.requetRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *page) {
        @strongify(self);
        return [[RACSignal empty] takeUntil:self.rac_willDeallocSignal];
    }];
    
    [[self.requetRemoteDataCommand.errors filter:[self requestRomoteDataErrorsFilter]] subscribe:self.errors];
}

- (id)fetchLocalData
{
    return nil;
}

- (BOOL (^)(NSError *error))requestRomoteDataErrorsFilter
{
    return ^(NSError *error){
        return YES;
    };
}

- (NSInteger)offsetForPage:(NSInteger)page
{
    return (page - 1) * self.limit;
}

- (RACSignal *)requestRemoteDataSignalWithPage:(NSInteger)page
{
    return [RACSignal empty];
}

@end
