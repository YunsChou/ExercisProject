//
//  WebViewModel.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "WebViewModel.h"

@implementation WebViewModel

- (instancetype)initWithServices:(id<BaseViewModelServices>)services params:(NSDictionary *)params
{
    self = [super initWithServices:services params:params];
    if (self) {
        self.request = params[@"request"];
    }
    return self;
}

@end
