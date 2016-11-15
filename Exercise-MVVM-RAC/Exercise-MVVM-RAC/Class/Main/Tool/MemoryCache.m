//
//  MemoryCache.m
//  Exercise-MVVM-RAC
//
//  Created by weiying on 2016/11/11.
//  Copyright © 2016年 yunschou. All rights reserved.
//

#import "MemoryCache.h"

@interface MemoryCache ()
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@end

@implementation MemoryCache

+ (instancetype)sharedInstance
{
    static MemoryCache *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MemoryCache alloc] init];
    });
    return _instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)objectForKey:(NSString *)key
{
    return [self.dictionary objectForKey:key];
}

- (void)setObject:(id)object forKey:(NSString *)key
{
    [self.dictionary setObject:object forKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
    [self.dictionary removeObjectForKey:key];
}

#pragma mark - lazy load
- (NSMutableDictionary *)dictionary
{
    if (!_dictionary) {
        self.dictionary = [NSMutableDictionary dictionary];
    }
    return _dictionary;
}



@end
