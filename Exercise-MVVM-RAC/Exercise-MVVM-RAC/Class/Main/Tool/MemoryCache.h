//
//  MemoryCache.h
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemoryCache : NSObject

+ (instancetype)sharedInstance;

- (id)objectForKey:(NSString *)key;

- (void)setObject:(id)object forKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

@end
