//
//  ZXInsetLabel.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/8.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXInsetLabel.h"

@interface ZXInsetLabel ()
@property (nonatomic, assign) UIEdgeInsets insets;
@end

@implementation ZXInsetLabel

- (instancetype)initWithFrame:(CGRect)frame andInset:(UIEdgeInsets)insets {
    if (self = [super initWithFrame:frame]) {
        self.insets = insets;
    }
    return self;
}

- (instancetype)initWithInsets:(UIEdgeInsets)insets {
    if (self = [super init]) {
        self.insets = insets;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}
@end
