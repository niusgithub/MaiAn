//
//  ZXRDTableViewCell.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/22.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXDoctor.h"
#import "ZXHospital.h"

#import "ZXRDTableViewCell.h"
#import "UIImage+ZX.h"
#import "NSString+ZX.h"
#import "UIImageView+ZXBorder.h"


#import "ZXMaiAnAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>

NSString *const kRDCellIdentifier = @"RDCellID";
NSString *const kRDTableCellNibName = @"ZXRDTableViewCell";
CGFloat const kRDTableCellHeight = 70;

@implementation ZXRDTableViewCell

- (void)configureRDCellWithDoctor:(ZXDoctor *)doctor {
    
    if (doctor.dc_portrait_path) {
        [self.RDAvatar sd_setImageWithURL:[NSURL URLWithString:[ZXMaiAn_RESOURCE_PREFIX stringByAppendingString:doctor.dc_portrait_path]] placeholderImage:[UIImage imageNamed:@"doctor"]];
    } else {
        [self.RDAvatar setImage:[UIImage imageNamed:@"doctor"]];
    }
    
    [self.RDAvatar addRoundBorderWithColor:[UIColor lightGrayColor]];
    
    
    self.RDName.text = [NSString stringWithFormat:@"%@  %@  %@", doctor.dc_name, doctor.dc_department, doctor.dc_title];
    self.RDHospital.text = doctor.dc_hos_name;
    self.RDDisease.text = doctor.dc_desc;
}

- (void)configureRDCellWithHospital:(ZXHospital *)hospital {
    if (hospital.hs_icon_path) {
        // 图片路径含有中文        
        [self.RDAvatar sd_setImageWithURL:[NSURL URLWithString:[ZXMaiAn_RESOURCE_PREFIX stringByAppendingString:[hospital.hs_icon_path stringTransToUTF8]]] placeholderImage:[UIImage imageNamed:@"hospital"]];
    } else {
        [self.RDAvatar setImage:[UIImage imageNamed:@"hospital"]];
    }
    
    [self.RDAvatar addRoundBorderWithColor:[UIColor lightGrayColor]];
    
    
    self.RDName.text = [NSString stringWithFormat:@"%@", hospital.hs_name];
    self.RDHospital.text = hospital.hs_area;
    self.RDDisease.text = hospital.hs_title;
}

@end
