//
//  ZXTableViewCell.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/2.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXTableViewItem;

@interface ZXTableViewCell : UITableViewCell

// cell对应的item数据
@property (nonatomic, strong) ZXTableViewItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows;

@end
