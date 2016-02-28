//
//  ZXUserInfoTVC.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXUserInfoTVCDelegate <NSObject>

- (void)toLogoutStatus;

@end

@interface ZXUserInfoTVC : UITableViewController

@property (nonatomic, weak) id<ZXUserInfoTVCDelegate> delegate;

@end
