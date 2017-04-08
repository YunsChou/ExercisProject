//
//  main.m
//  tr4-addIvar
//
//  Created by weiying on 16/3/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Property.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        NSObject *obj = [NSObject new];
        obj.name = @"张三";
        NSLog(@"obj.name -- %@",obj.name);
    }
    return 0;
}
