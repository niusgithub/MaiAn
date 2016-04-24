//
//  ZXDocClinicServiceCell.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/4.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXDocClinicServiceCell.h"
#import "ZXAccountTool.h"
#import "MBProgressHUD+MJ.h"

@implementation ZXDocClinicServiceCell

- (IBAction)talkToDoctor:(UIButton *)sender {
    if ([ZXAccountTool shareAccount]) {
        if ([self.delegate respondsToSelector:@selector(contactWithDoctor)]) {
            [self.delegate contactWithDoctor];
        }
    } else {
        [MBProgressHUD showError:@"请先登录"];
    }
}

- (IBAction)callTheDoctor:(UIButton *)sender {
    NSLog(@"callTheDoctor");
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

}

@end
