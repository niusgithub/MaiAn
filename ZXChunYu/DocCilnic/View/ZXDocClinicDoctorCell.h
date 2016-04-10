//
//  ZXDocClinicDoctorCell.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/28.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXDoctor;

@protocol ZXDocClinicDoctorCellDelegate <NSObject>

- (void)changeFollowStatus:(BOOL)stauts;

@end

@interface ZXDocClinicDoctorCell : UITableViewCell

@property (nonatomic, assign, getter=isFollowed) BOOL followed;
@property (nonatomic, weak) id<ZXDocClinicDoctorCellDelegate> delegate;

- (void)configureDCDCellWithDoctor:(ZXDoctor *)doctor;

@end
