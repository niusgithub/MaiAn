//
//  UIBarButtonItem+ZX.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/25.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "UIBarButtonItem+ZX.h"
#import "UIView+XZX.h"

@implementation UIBarButtonItem (ZX)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                                target:(id)target
                                action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
