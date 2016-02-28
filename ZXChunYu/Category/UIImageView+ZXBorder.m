//
//  UIImageView+ZXBorder.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/14.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "UIImageView+ZXBorder.h"

@implementation UIImageView (ZXBorder)

- (void)addRoundBorderWithColor:(UIColor *)color {
    self.layer.cornerRadius = self.frame.size.width / 2;
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [color CGColor];
    self.clipsToBounds = YES;
}
@end
