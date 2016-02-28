//
//  ZXRDTableViewCell.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/22.
//  Copyright © 2015年 陈知行. All rights reserved.
//
//  RD = recommendedDoctor

@class ZXDoctor, ZXHospital;

#import <UIKit/UIKit.h>

extern NSString *const kRDCellIdentifier;
extern NSString *const kRDTableCellNibName;
extern CGFloat const kRDTableCellHeight;

@interface ZXRDTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *RDAvatar;
@property (weak, nonatomic) IBOutlet UILabel *RDName;
@property (weak, nonatomic) IBOutlet UILabel *RDHospital;
@property (weak, nonatomic) IBOutlet UILabel *RDDisease;

- (void)configureRDCellWithDoctor:(ZXDoctor *)doctor;
- (void)configureRDCellWithHospital:(ZXHospital *)hospital;

@end
