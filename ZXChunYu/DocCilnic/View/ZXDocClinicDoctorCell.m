//
//  ZXDocClinicDoctorCell.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/28.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXDocClinicDoctorCell.h"
#import "ZXDoctor.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXCommon.h"
#import "ZXMaiAnAPI.h"

#import "MBProgressHUD+MJ.h"
#import "UIImageView+ZXBorder.h"
#import "UIColor+ZX.h"

#import <SDWebImage/UIImageView+WebCache.h>

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
    
    // 关注按钮与边框样式
    self.followBtn.layer.borderWidth = 1.f;
    self.followBtn.layer.cornerRadius = 4.5;

    // 设置头像
    // sdwebimage会从缓存中查找后读取已经下载的图片 缓存type有none disk memory三种  keyPath是url？(不确定)
    if (doctor.dc_portrait_path) {
        [self.docAvatarIV sd_setImageWithURL:[NSURL URLWithString:[ZXMaiAn_RESOURCE_PREFIX stringByAppendingString:doctor.dc_portrait_path]] placeholderImage:[UIImage imageNamed:@"doctor"]];
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

- (void)setFollowed:(BOOL)followed {
    _followed = followed;

    if (followed) {
        // 橙色
        [self.followBtn setTitle:NSLocalizedString(@"Followed", nil) forState:UIControlStateNormal];
        [self.followBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.followBtn.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    } else {
        // 主题绿色
        [self.followBtn setTitle:NSLocalizedString(@"unFollowed", nil) forState:UIControlStateNormal];
        [self.followBtn setTitleColor:[UIColor themeColor] forState:UIControlStateNormal];
        [self.followBtn.layer setBorderColor:[[UIColor themeColor] CGColor]];
    }
}

// 关注医生
- (IBAction)followADoctor {
    if ([ZXAccountTool shareAccount]) {
        self.followed = !_followed;
        if ([self.delegate respondsToSelector:@selector(changeFollowStatus:)]) {
            [self.delegate changeFollowStatus:_followed];
        }
    } else {
        [MBProgressHUD showError:@"请先登录"];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

@end
