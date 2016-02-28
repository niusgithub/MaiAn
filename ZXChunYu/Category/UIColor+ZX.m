//
//  UIColor+ZX.m
//  ZXChunYu
//
//  Created by 陈知行 on 15/11/27.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "UIColor+ZX.h"

@implementation UIColor (ZX)

#pragma mark - Hex

+ (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}


#pragma mark - theme colors

+ (UIColor *)colorWithHex:(int)hexValue {
    return [UIColor colorWithHex:hexValue alpha:1.0];
}

+ (UIColor *)themeColor {
    // (81, 211, 101, 1)  0x51D366
    return [UIColor colorWithRed:81.0/255.0 green:211.0/255.0 blue:101.0/255.0 alpha:1];
}

+ (UIColor *)themeBGColor {
    return [UIColor colorWithRed:241.0/255.0 green:240.0/255.0 blue:238.0/255.0 alpha:1];
}


+ (UIColor *)titleColor {
    return [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];

}

+ (UIColor *)titleBarColor {
    return [UIColor colorWithHex:0xE1E1E1];
}

@end
