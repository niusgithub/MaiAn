//
//  NSString+ZXTextSize.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/5.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "NSString+ZX.h"

@implementation NSString (ZX)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (NSString *)stringTransToUTF8 {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 kCFAllocatorDefault,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 NULL,
                                                                                 kCFStringEncodingUTF8
                                                                                 ));
}

@end
