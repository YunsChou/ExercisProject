//
//  Person.h
//  EX-RAC-DEMO
//
//  Created by weiying on 2016/12/5.
//  Copyright © 2016年 amoby. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Person;

typedef Person * (^nameBlock)(NSString *name);

typedef Person * (^workBlock)();

@interface Person : NSObject

- (nameBlock)who;

- (workBlock)work;

@end
