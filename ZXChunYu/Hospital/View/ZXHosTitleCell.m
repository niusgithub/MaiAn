//
//  ZXHosTitleCell.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/4.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXHosTitleCell.h"

NSString *const kHosTitleCellIdentifier = @"HTCellID";
NSString *const kHosTitleCellNibName = @"ZXHosTitleCell";
CGFloat const kHosTitleCellHeight = 30;

@interface ZXHosTitleCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation ZXHosTitleCell

- (void)configureCellWithTitle:(NSString *)title {
    self.titleL.text = title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
