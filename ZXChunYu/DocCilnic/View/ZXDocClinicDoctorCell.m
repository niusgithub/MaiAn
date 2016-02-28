//
//  ZXDocClinicDoctorCell.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/28.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXDocClinicDoctorCell.h"
#import "ZXDoctor.h"

#import "ZXCommon.h"
#import "ZXChunYuAPI.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "UIImageView+ZXBorder.h"
#import "UIColor+ZX.h"

@interface ZXDocClinicDoctorCell ()
@property (weak, nonatomic) IBOutlet UIImageView *docAvatarIV;
@property (weak, nonatomic) IBOutlet UILabel *docNameTF;
@property (weak, nonatomic) IBOutlet UILabel *docDepartmentTF;
@property (weak, nonatomic) IBOutlet UILabel *docHospitalTF;
@property (weak, nonatomic) IBOutlet UILabel *followerNumberL;
@property (weak, nonatomic) IBOutlet UILabel *serveNumberL;
@property (weak, nonatomic) IBOutlet UILabel *recommendNumberL;

@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@property (nonatomic, strong, readonly) ZXDoctor *doctor;
@end

@implementation ZXDocClinicDoctorCell

- (void)configureDCDCellWithDoctor:(ZXDoctor *)doctor {
    _doctor = doctor;
    
    // 关注按钮加边框
    self.followBtn.layer.borderWidth = 1.f;
    self.followBtn.layer.cornerRadius = 4.5;
    [self.followBtn.layer setBorderColor:[[UIColor themeColor] CGColor]];
    //self.followBtn.layer.masksToBounds = YES;
    
    // 设置头像
    // sdwebimage会从内存中查找后读取已经下载的图片 但或许应该换个直接读取的方法？
    if (doctor.dc_portrait_path) {
        [self.docAvatarIV sd_setImageWithURL:[NSURL URLWithString:[ZXChunYu_RESOURCE_PREFIX stringByAppendingString:doctor.dc_portrait_path]] placeholderImage:[UIImage imageNamed:@"doctor"]];
    } else {
        [self.docAvatarIV setImage:[UIImage imageNamed:@"doctor"]];
    }
    
    [self.docAvatarIV addRoundBorderWithColor:[UIColor lightGrayColor]];
    
    // 设置医生名
    self.docNameTF.text = doctor.dc_name;
    //
    self.docDepartmentTF.text = [NSString stringWithFormat:@"%@  %@", doctor.dc_department, doctor.dc_title];
    //
    self.docHospitalTF.text = doctor.dc_hos_name;
    //
    self.followerNumberL.text = doctor.followerNum;
    //
    self.serveNumberL.text = doctor.serveNum;
    //
    self.recommendNumberL.text = doctor.dc_recommend;
}

// 关注医生
- (IBAction)followADoctor {
    NSLog(@"关注医生--%@", self.doctor.dc_name);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

@end
