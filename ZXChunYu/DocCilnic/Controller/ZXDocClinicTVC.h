//
//  ZXDocClinicTVC.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/28.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXBasicDynamicTVC.h"

@class ZXDoctor;

@interface ZXDocClinicTVC : ZXBasicDynamicTVC

- (instancetype)initClinicWithDoctor:(ZXDoctor *)doctor;

@end
