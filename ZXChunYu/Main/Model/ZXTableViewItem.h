//
//  ZXTableViewItem.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/2.
//  Copyright © 2015年 陈知行. All rights reserved.
//
//  描述每行的信息：图标、标题、子标题、右边的样式（箭头、文字、数字、开关、打钩）

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZXTableViewItem : NSObject

typedef NS_ENUM(NSInteger, ZXTableViewCellType) {
    ZXTableViewCellTypeAd,
    ZXTableViewCellTypeArrow,
    ZXTableViewCellTypeLabel,
    ZXTableViewCellTypeSwitch,
};

// 图标
@property (nonatomic, copy) NSString *icon;
// 标题
@property (nonatomic, copy) NSString *title;
// 子标题
@property (nonatomic, copy) NSString *subTitle;
// BadgeValue
@property (nonatomic, copy) NSString *badageValue;
// 文字
@property (nonatomic, copy) NSString *text;
// 类型
@property (nonatomic, assign) ZXTableViewCellType type;
// 点击后跳转的控制器
@property (nonatomic, assign) Class destVCClass;

// cell的行为
// block只能用copy
@property (nonatomic, copy) void *(^operation)();

+ (instancetype)itemWithType:(ZXTableViewCellType)type title:(NSString *)title icon:(NSString *)icon;
+ (instancetype)itemWithType:(ZXTableViewCellType)type;

@end
