//
//  ZXHosTitleCell.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/4.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kHosTitleCellIdentifier;
extern NSString *const kHosTitleCellNibName;
extern CGFloat const kHosTitleCellHeight;

@interface ZXHosTitleCell : UITableViewCell

- (void)configureCellWithTitle:(NSString *)title;

@end
