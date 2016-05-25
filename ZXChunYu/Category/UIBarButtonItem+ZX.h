//
//  UIBarButtonItem+ZX.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/25.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZX)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                                target:(id)target
                                action:(SEL)action;

@end
