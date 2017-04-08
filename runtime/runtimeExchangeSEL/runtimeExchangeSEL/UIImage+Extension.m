//
//  UIImage+Extension.m
//  runtimeExchangeSEL
//
//  Created by weiying on 16/3/8.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "UIImage+Extension.h"
#import <objc/runtime.h>

@implementation UIImage (Extension)

+ (void)load
{
    Method method1 = class_getClassMethod([self class], @selector(imageNamed:));
    Method method2 = class_getClassMethod([self class], @selector(runtimeImageNamed:));
    method_exchangeImplementations(method1, method2);
}

+ (instancetype)runtimeImageNamed:(NSString *)imageName
{
    NSLog(@"图片名称 -- %@",imageName);
//    UIImage *image = [self imageNamed:imageName];
    UIImage *image = [self runtimeImageNamed:imageName];
    return image;
}

@end
