//
//  ZXCommon.h
//  ZXChunYu
//
//  Created by yunmu on 15/11/27.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#ifndef ZXCommon_h
#define ZXCommon_h

// 调试状态，打开log
#ifdef DEBUG
#define XZXLog(...) NSLog(__VA_ARGS__)
#else // 发布状态,关闭log功能
#define XZXLog(...)
#endif

// 颜色
#define XZXColor(R, G, B, A) [UIColor colorWithRed:(R)/255.0 green:(G)/255.0 blue:(B)/255.0 alpha:(A)/1.0]

// 随机色
#define XZXRandomColor XZXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), 1)

// TabBar
#define ZXGrayColor XZXColor(91, 92, 89, 1) //Hex 5B5C59

// TableView
#define tableViewBackgroundColor XZXColor(211, 211, 211, 1)

// Margin
static const int kCellMargin = 10;

// System
#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width [[UIScreen mainScreen] bounds].size.width
#define System_Version [[[UIDevice currentDevice] systemVersion] doubleValue]
#define RootViewController [UIApplication sharedApplication].keyWindow.rootViewController
#define RootWindow [UIApplication sharedApplication].keyWindow
#define MainFrame [[UIScreen mainScreen] bounds]

// JVFloatLableTextField
const static float kJVFieldFontSize = 20.0f;
const static float kJVFieldFloatingLabelFontSize = 16.0f;

#endif /* ZXCommon_h */
