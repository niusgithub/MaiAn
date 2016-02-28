//
//  ZXUserProfileCell.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/7.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kUPCellNibName;
extern NSString *const kUPCellIdentifier;
extern CGFloat const kUPCellHeight;

@class ZXAccount;

@protocol ZXUserProfileCellDelegate <NSObject>

- (void)changeUserAvatar;

@end

@interface ZXUserProfileCell : UITableViewCell

@property (nonatomic, weak) id<ZXUserProfileCellDelegate> delegate;

- (void)configureUserProfileCellWithAccount:(ZXAccount *)account;

@end
