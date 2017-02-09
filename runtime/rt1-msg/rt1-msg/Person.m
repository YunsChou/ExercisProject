//
//  Person.m
//  rt1-msg
//
//  Created by weiying on 16/3/1.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)eat
{
    NSLog(@"person -instance- eat");
}

+ (void)eat
{
    NSLog(@"person -class- eat");
}

@end
