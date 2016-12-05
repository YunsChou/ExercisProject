//
//  BaseMacro.h
//  EX-XMHelper
//
//  Created by Yuns on 2016/12/3.
//  Copyright © 2016年 Yuns. All rights reserved.
//

#ifndef BaseMacro_h
#define BaseMacro_h

///Version
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

///Size
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

///Scale
#define SCREEN_SCALE (SCREEN_WIDTH / 375)

///NSLog
#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#define DLogError(error) NSLog(@"Error: %@", error)
#else
#define DLog(...)
#define DLogError(error)
#endif



///Color
#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBA(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define RGBRandom RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#endif /* BaseMacro_h */
