//
//  ZXHospital.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXHospital.h"
#import "ZXDoctor.h"
#import "YYModel.h"

@implementation ZXHospital

// hs_docs

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"hs_docs" : [ZXDoctor class]
             };
}


@end
