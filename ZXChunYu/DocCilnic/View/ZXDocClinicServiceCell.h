//
//  ZXDocClinicServiceCell.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/4.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXDocClinicServiceCellDelegate <NSObject>

- (void)contactWithDoctor;

@end

@interface ZXDocClinicServiceCell : UITableViewCell

@property (nonatomic, weak) id<ZXDocClinicServiceCellDelegate> delegate;

@end
