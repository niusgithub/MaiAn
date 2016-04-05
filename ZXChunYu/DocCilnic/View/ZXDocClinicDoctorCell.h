//
//  ZXDocClinicDoctorCell.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/28.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXDoctor;

typedef NS_ENUM(NSInteger, ZXDocClinicDoctorCellType) {
    ZXDocClinicDoctorFollowed,
    ZXDocClinicDoctorUnFollowed
};

@interface ZXDocClinicDoctorCell : UITableViewCell

@property (nonatomic, assign) ZXDocClinicDoctorCellType type;

- (void)configureDCDCellWithDoctor:(ZXDoctor *)doctor;

@end
