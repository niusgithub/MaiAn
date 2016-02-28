//
//  UIColor+ZX.h
//  ZXChunYu
//
//  Created by 陈知行 on 15/11/27.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZX)

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(int)hexValue;

+ (UIColor *)themeColor;
+ (UIColor *)themeBGColor;

+ (UIColor *)titleColor;
+ (UIColor *)titleBarColor;


@end
