//
//  TYGSelectMenuCellTableViewCell.h
//  TYGSelectMenu
//
//  Created by tanyugang on 15/7/7.
//  Copyright (c) 2015年 tanyugang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYGSelectMenuCellTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, weak) IBOutlet UIView *bg_mainView;
@property (nonatomic, weak) IBOutlet UIView *bg_leftView;

@end
