//
//  HTTPRequestTool.m
//  HotLibApp
//
//  Created by weiying on 16/9/13.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "HTTPRequestTool.h"
#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, HTTPRequestMethodType) {
    HTTPRequestMethod_GET = 1,   //GET
    HTTPRequestMethod_POST= 2    //POST
};

@interface HTTPRequestTool ()
@property (nonatomic, copy) NSString *baseUrl;
@end

@implementation HTTPRequestTool

+ (instancetype)shareInstance
{
    static HTTPRequestTool *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (void)setHTTPBaseUrl:(NSString *)baseUrl
{
    _baseUrl = baseUrl;
}

//GET方法
- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(NetworkResponseSuccess)success
    failure:(NetworkResponseFail)failure
{
    [self request:URLString parameters:parameters httpMethod:HTTPRequestMethod_GET success:success failure:failure];
}

//POST方法
- (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(NetworkResponseSuccess)success
     failure:(NetworkResponseFail)failure
{
    [self request:URLString parameters:parameters httpMethod:HTTPRequestMethod_POST success:success failure:failure];
}

- (void)request:(NSString *)URLString
     parameters:(id)parameters
     httpMethod:(HTTPRequestMethodType)httpMethod
        success:(NetworkResponseSuccess)success
        failure:(NetworkResponseFail)failure
{
    //1、初始化：
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2、设置请求超时时间：
    manager.requestSerializer.timeoutInterval = 30.0f;
    //3、设置请求和响应数据格式:需要注意的是,默认提交请求的数据是二进制的,返回格式是JSON
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //4、设置允许接收返回数据类型：
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    //5、是否有请求头和baseUrl
    if (_baseUrl) {
        URLString = [_baseUrl stringByAppendingString:URLString];
    }
    //6、发起网络请求：
    if (httpMethod == HTTPRequestMethod_GET) {//GET请求
        [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }else if (httpMethod == HTTPRequestMethod_POST){//POST请求
        [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

@end
