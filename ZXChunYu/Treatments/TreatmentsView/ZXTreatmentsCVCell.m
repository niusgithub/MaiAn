//
//  ZXTreatmentsCVCell.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/17.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXTreatmentsCVCell.h"
#import "ZXTreatments.h"

#import "ZXChunYuAPI.h"
#import "NSString+ZX.h"

#import <SDWebImage/UIImageView+WebCache.h>

NSString *const kTreatmentsCellIdentifier = @"TreamentsCVCell";
NSString *const kTreatmentsCellNibName = @"ZXTreatmentsCVCell";

@interface ZXTreatmentsCVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *treatmentsIV;
@property (weak, nonatomic) IBOutlet UILabel *treatmentsNameL;

@end


@implementation ZXTreatmentsCVCell

- (void)awakeFromNib {
    self.contentView.layer.cornerRadius = 6;
    self.contentView.layer.masksToBounds = YES;
    
    self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.contentView.layer.borderWidth = 1.f;
    
    _treatmentsIV.contentMode = UIViewContentModeScaleAspectFill;
    _treatmentsIV.clipsToBounds = YES;
}

//- (void)prepareForReuse {
//    [super prepareForReuse];
//    
//    _treatmentsIV.image = nil;
//}

- (void)configureWithTreatments:(ZXTreatments *)treatments {
    if (treatments.gs_icon_path) {
        
        // .....utf-8 -> GBK -> utf-8
        NSString *GBK = [treatments.gs_icon_path stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [_treatmentsIV sd_setImageWithURL:[NSURL URLWithString:[ZXChunYu_RESOURCE_PREFIX stringByAppendingString:[GBK stringTransToUTF8]]] placeholderImage:[UIImage imageNamed:@"hospital"]];
    } else {
        _treatmentsIV.image = nil;
    }
    
    _treatmentsNameL.text = treatments.gs_name;
}

@end
