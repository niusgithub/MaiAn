//
//  ZXInsetLabel.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/8.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXInsetLabel : UILabel

- (instancetype)initWithFrame:(CGRect)frame andInset:(UIEdgeInsets)insets;

- (instancetype)initWithInsets:(UIEdgeInsets)insets;

@end
