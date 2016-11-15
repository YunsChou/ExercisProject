//
//  HTTPRequestTool.h
//  HotLibApp
//
//  Created by weiying on 16/9/13.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NetworkResponseSuccess)(id response);
typedef void (^NetworkResponseFail)(NSError *error);

@interface HTTPRequestTool : NSObject

+ (instancetype)shareInstance;

- (void)setHTTPBaseUrl:(NSString *)baseUrl;

//GET方法
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(NetworkResponseSuccess)success
    failure:(NetworkResponseFail)failure;

//POST方法
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(NetworkResponseSuccess)success
     failure:(NetworkResponseFail)failure;

@end
