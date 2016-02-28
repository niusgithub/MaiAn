//
//  ZXHealthNewsTVC.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXBasicDynamicTVC.h"
//commonSenseHN, symptomHN, diagnosisHN, preventionHN
typedef NS_ENUM(NSInteger, ZXHealthNewsType) {
    ZXHealthNewsCommomSense,
    ZXHealthNewsSymoptom,
    ZXHealthNewsDiagnosis,
    ZXHealthNewsPrevention
};

@interface ZXHealthNewsTVC : ZXBasicDynamicTVC

- (instancetype)initWithHealthNewsType:(ZXHealthNewsType)type;

@end
