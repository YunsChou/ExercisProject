//
//  main.m
//  rt3-addSEL
//
//  Created by weiying on 16/3/4.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *p = [[Person alloc] init];
        [p performSelector:@selector(eat:) withObject:@"123"];
        
    }
    return 0;
}
