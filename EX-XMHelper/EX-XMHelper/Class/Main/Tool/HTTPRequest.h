//
//  HTTPRequest.h
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/3.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPRequest : NSObject

+ (instancetype)sharedInstance;

- (RACSignal *)fetchJSONFromUrlString:(NSString *)urlString;

@end
