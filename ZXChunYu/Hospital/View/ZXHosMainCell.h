//
//  ZXHosMainCell.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/21.
//  Copyright © 2016年 陈知行. All rights reserved.
//

@class ZXHospital;

#import <UIKit/UIKit.h>

extern NSString *const kHosMainCellIdentifier;
extern NSString *const kHosMainCellNibName;
extern CGFloat const kHosMainCellHeight;

@interface ZXHosMainCell : UITableViewCell

- (void)configureHMCellWithHospital:(ZXHospital *)hospital;

@end
