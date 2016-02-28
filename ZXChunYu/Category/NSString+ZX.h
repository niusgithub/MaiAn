//
//  NSString+ZX.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/5.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZX)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

- (NSString *)stringTransToUTF8;

@end
