//
//  ZXBadgeView.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/3.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXBadgeView.h"
#import "UIView+ZX.h"
#import "NSString+ZX.h"

@implementation ZXBadgeView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = [badgeValue copy];
    
    // 设置文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 根据文字计算尺寸
    CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font maxSize:CGSizeMake(200, CGFLOAT_MAX)];
    
    //CGSize titleSize = [badgeValue sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:(nonnull NSString *) size:(CGFloat)]}]
    CGFloat bgW = self.currentBackgroundImage.size.width;
    if (titleSize.width < bgW) {
        self.width = bgW;
    } else {
        self.width = titleSize.width + 10;
    }
}

@end
