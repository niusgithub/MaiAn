//
//  ZXTableViewCell.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/2.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXTableViewCell.h"
#import "ZXBadgeView.h"
#import "ZXTableViewItem.h"

#import "UIView+ZX.h"
#import "UIImage+ZX.h"
#import "NSString+ZX.h"

@interface ZXTableViewCell()
// 箭头
@property (nonatomic, strong) UIImageView *rightArrow;
// 开关
@property (nonatomic, strong) UISwitch *rightSwitch;
// 标签
@property (nonatomic, strong) UILabel *rightLablel;
// 提醒数字
@property (nonatomic, strong) ZXBadgeView *badgeView;
@end

@implementation ZXTableViewCell

#pragma mark - lazy
- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch {
    if (!_rightSwitch) {
        self.rightSwitch = [[UISwitch alloc] init];
    }
    return _rightSwitch;
}

- (UILabel *)rightLablel {
    if (!_rightLablel) {
        self.rightLablel = [[UILabel alloc] init];
        self.rightLablel.textColor = [UIColor grayColor];
        self.rightLablel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLablel;
}

- (ZXBadgeView *)badgeView {
    if (!_badgeView) {
        self.badgeView = [[ZXBadgeView alloc] init];
    }
    return _badgeView;
}

#pragma mark - init
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseID = @"commom";
    ZXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[ZXTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 设置标题字体
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:11];
        
        // 去除cell的默认色
        self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark - layout
- (void)layoutSubviews {
    [super layoutSubviews];
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

#pragma mark - setter
- (void)setItem:(ZXTableViewItem *)item {
    _item = item;
    
    // 设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
    // 设置右边的内容
    if (item.badageValue) {
        self.badgeView.badgeValue = item.badageValue;
        self.accessoryView = self.badgeView;
    } else if (item.type == ZXTableViewCellTypeArrow) {
        self.accessoryView = self.rightArrow;
    } else if (item.type == ZXTableViewCellTypeSwitch) {
        self.accessoryView = self.rightSwitch;
    } else if (item.type == ZXTableViewCellTypeLabel) {
        // 设置文字
        self.rightLablel.text = item.text;
        // 计算尺寸
        self.rightLablel.size = [item.text sizeWithFont:self.rightLablel.font maxSize:CGSizeMake(200, CGFLOAT_MAX)];
        self.accessoryView = self.rightLablel;
    } else {
        self.accessoryView = nil;
    }
}


- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows {
    // 取出背景view
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    // 设置背景图片
    if (rows == 1) {
        bgView.image = [UIImage resizedImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    }
//    else if (indexPath.row == 0) { // 首行
//        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
//        selectedBgView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
//    }
    else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
}
@end









