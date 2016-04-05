//
//  ZXHosMainCell.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/21.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXHosMainCell.h"
#import "ZXHospital.h"

#import "NSString+ZX.h"

#import "ZXMaiAnAPI.h"

#import <SDWebImage/UIImageView+WebCache.h>

NSString *const kHosMainCellIdentifier = @"HMCellID";
NSString *const kHosMainCellNibName = @"ZXHosMainCell";
CGFloat const kHosMainCellHeight = 190;

@interface ZXHosMainCell ()
@property (weak, nonatomic) IBOutlet UIImageView *hospitalIV;
@property (weak, nonatomic) IBOutlet UILabel *hosptialTitleL;
@property (weak, nonatomic) IBOutlet UILabel *hosptialTeleL;

@end

@implementation ZXHosMainCell

- (void)configureHMCellWithHospital:(ZXHospital *)hospital {
    if ([hospital.imagePaths firstObject]) {
        NSString *imgURL = [(NSString *)[hospital.imagePaths firstObject] stringTransToUTF8];
        [self.hospitalIV sd_setImageWithURL:[NSURL URLWithString:[ZXMaiAn_RESOURCE_PREFIX stringByAppendingString:imgURL]]];
    }
    self.hosptialTitleL.text = hospital.hs_title;
    self.hosptialTeleL.text = hospital.hs_phone;
}

@end
