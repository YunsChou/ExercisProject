//
//  YsMacro.h
//  HotLibApp
//
//  Created by weiying on 16/9/1.
//  Copyright © 2016年 amoby. All rights reserved.
//

#ifndef YsMacro_h
#define YsMacro_h

//设备系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//获取设备屏幕尺寸
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
//以iPhone6屏幕宽度为基准，定义比例
#define SCREEN_SCALE (SCREEN_WIDTH / 375)

/**
 *  调试模式下的打印输出
 */
#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#endif

/**
 *  颜色的R,G,B,A
 */
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0)
#define RandomColor RGB(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256))

#endif /* YsMacro_h */
