//
//  NSObject+Property.m
//  runtimeDictModel
//
//  Created by weiying on 16/3/17.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import "NSObject+Property.h"

@implementation NSObject (Property)

- (void)createPropertyCode
{
    NSMutableString *mStr = [NSMutableString string];
    id idSelf = self;
    [idSelf enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSLog(@"key -- %@, value -- %@",key,[obj class]);
        NSString *code = nil;
        if ([obj isKindOfClass:NSClassFromString(@"__NSCFConstantString")]) {
            code = [NSString stringWithFormat:@"@property (nonatomic, copy) NSString *%@",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFBoolean")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) BOOL %@",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSCFNumber")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, assign) NSInteger %@",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSDictionaryI")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSDictionary *%@",key];
        }else if ([obj isKindOfClass:NSClassFromString(@"__NSArrayI")]){
            code = [NSString stringWithFormat:@"@property (nonatomic, strong) NSArray *%@",key];
        }
        [mStr appendFormat:@"\n%@\n",code];
    }];
    
    NSLog(@"mStr -- %@",mStr);
}

@end
