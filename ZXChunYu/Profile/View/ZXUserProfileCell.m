//
//  ZXUserProfileCell.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/7.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXUserProfileCell.h"
#import "ZXAccount.h"
#import "ZXChunYuAPI.h"

#import "UIImageView+ZXBorder.h"

#import <SDWebImage/UIImageView+WebCache.h>

NSString *const kUPCellNibName = @"ZXUserProfileCell";
NSString *const kUPCellIdentifier = @"UPCellID";
CGFloat const kUPCellHeight = 100;

@interface ZXUserProfileCell ()
@property (weak, nonatomic) IBOutlet UILabel *userNameL;
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarIV;
@end

@implementation ZXUserProfileCell

- (void)configureUserProfileCellWithAccount:(ZXAccount *)account {
    
    _userNameL.text = account.username;
    
    if (account.u_portrait_path) {
        [_userAvatarIV sd_setImageWithURL:[NSURL URLWithString:[ZXChunYu_RESOURCE_PREFIX stringByAppendingString:account.u_portrait_path]] placeholderImage:[UIImage imageNamed:@"doctor"]];
    } else {
        [_userAvatarIV setImage:[UIImage imageNamed:@"doctor"]];
    }
    
    [_userAvatarIV addRoundBorderWithColor:[UIColor lightGrayColor]];
    
    [_userAvatarIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAvatarSheet)]];
}

- (void)showAvatarSheet {
    if ([self.delegate respondsToSelector:@selector(changeUserAvatar)]) {
        [self.delegate changeUserAvatar];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
