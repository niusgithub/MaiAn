//
//  ZXTableViewItem.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/2.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXTableViewItem.h"

@implementation ZXTableViewItem

+ (instancetype)itemWithType:(ZXTableViewCellType)type title:(NSString *)title icon:(NSString *)icon {
    ZXTableViewItem *item = [[self alloc] init];
    item.type = type;
    item.title = [title copy];
    item.icon = [icon copy];
    return item;
}

+ (instancetype)itemWithType:(ZXTableViewCellType)type{
    return [self itemWithType:type title:nil icon:nil];
}

@end
