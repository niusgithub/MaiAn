//
//  ZXDoctor.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/18.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXDoctor : NSObject

// 医生ID
@property (nonatomic, copy) NSString *did;
// 姓名
@property (nonatomic, copy) NSString *dc_name;
// 科室
@property (nonatomic, copy) NSString *dc_department;
// 职称
@property (nonatomic, copy) NSString *dc_title;
// 所在区域
@property (nonatomic, copy) NSString *dc_area;
// 所在医院名称
@property (nonatomic, copy) NSString *dc_hos_name;
// 专长治疾病
@property (nonatomic, copy) NSString *dc_desc;
// 推荐度
@property (nonatomic, copy) NSString *dc_recommend;
// 头像地址
@property (nonatomic, copy) NSString *dc_portrait_path;
// 医院ID
@property (nonatomic, copy) NSString *hid;

//
@property (nonatomic, copy) NSString *followerNum;
//
@property (nonatomic, copy) NSString *serveNum;
@end
