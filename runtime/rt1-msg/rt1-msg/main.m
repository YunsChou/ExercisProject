//
//  main.m
//  rt1-msg
//
//  Created by weiying on 16/3/1.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");

        [Person eat];
        
        Person *p = [[Person alloc] init];
        [p eat];
        
        [[Person class] eat];
    }
    return 0;
}
