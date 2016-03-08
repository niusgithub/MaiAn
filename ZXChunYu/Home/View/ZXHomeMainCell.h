//
//  ZXHomeMainCell.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/8.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXVerticalButton.h"

extern NSString* const kHomeMainCellID;
extern NSString* const kHomeMainCellNibName;
extern const CGFloat kHomeMainCellHeight;

@interface ZXHomeMainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ZXVerticalButton *questionBtn;
@property (weak, nonatomic) IBOutlet ZXVerticalButton *search4HosBtn;
@property (weak, nonatomic) IBOutlet ZXVerticalButton *search4DocBtn;
@property (weak, nonatomic) IBOutlet ZXVerticalButton *selfDigonseBtn;

@end
