//
//  Person.m
//  rt3-addSEL
//
//  Created by weiying on 16/3/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@implementation Person

void eat(id self, SEL _cmd, NSString *str){
    NSLog(@"动态添加吃的方法 -- %@",str);
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"方法名-- %@",NSStringFromSelector(sel));
    if (sel == @selector(eat:)) {
        class_addMethod(self, sel, (IMP)eat, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//+ (BOOL)resolveClassMethod:(SEL)sel
//{
//    NSLog(@"方法名-- %@",NSStringFromSelector(sel));
//    if (sel == @selector(eat:)) {
//        class_addMethod(self, sel, (IMP)eat, "v@:@");
//        return YES;
//    }
//    return [super resolveClassMethod:sel];
//}

@end
