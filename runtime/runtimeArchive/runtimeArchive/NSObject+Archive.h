//
//  NSObject+Archive.h
//  runtimeArchive
//
//  Created by weiying on 16/5/19.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YSCoding <NSObject>

@optional
- (NSArray *)ys_ignoredCodingPropertyName;

@end

@interface NSObject (Archive) <YSCoding>
/**归档*/
- (void)ys_encodeWithCoder:(NSCoder *)aCoder;
/**解归档*/
- (void)ys_decodeWithCoder:(NSCoder *)aDecoder;

@end
