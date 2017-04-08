//
//  UIImage+rtExtension.m
//  rt2-excSEL
//
//  Created by weiying on 16/3/1.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "UIImage+rtExtension.h"
#import <objc/runtime.h>

@implementation UIImage (rtExtension)

+ (void)load
{
    Method m1 = class_getClassMethod(self, @selector(imageNamed:));
    Method m2 = class_getClassMethod(self, @selector(rt_imageName:));
    method_exchangeImplementations(m1, m2);
}

+ (instancetype)rt_imageName:(NSString *)name
{
    NSLog(@"图片名称 -- %@",name);
//    UIImage *imgErr = [self imageNamed:name];
    UIImage *img = [self rt_imageName:name];
    return img;
}

@end
