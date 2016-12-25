//
//  Animal.m
//  EX-RAC-DEMO
//
//  Created by Yuns on 2016/12/25.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (Animal *)run
{
    NSLog(@"run -- ");
    return self;
}

- (Animal *)jump
{
    NSLog(@"jump -- ");
    return self;
}

- (Animal *)say:(NSString *)words
{
    NSLog(@"say -- %@", words);
    return self;
}

@end
