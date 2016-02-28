//
//  ZXDocClinicTitleCell.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/4.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXDocClinicTitleCell.h"

@interface ZXDocClinicTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *moreL;
@end

@implementation ZXDocClinicTitleCell

- (void)configureDCTCellWithTitle:(NSString *)title andMore:(NSString *)more {
    self.titleL.text = title;
    self.moreL.text = more;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
