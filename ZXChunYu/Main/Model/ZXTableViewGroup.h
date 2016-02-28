//
//  ZXTableViewGroup.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/2.
//  Copyright © 2015年 陈知行. All rights reserved.
//
//  描述每组的信息：组头、组尾、这组的所有行模型

#import <Foundation/Foundation.h>

@interface ZXTableViewGroup : NSObject
// 头部
@property (nonatomic, copy) NSString *header;
// 尾部
@property (nonatomic, copy) NSString *footer;
// 所有行模型
@property (nonatomic, strong) NSArray *items;

+ (instancetype)group;

@end
