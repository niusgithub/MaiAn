//
//  ZXCheckVerificationCodeVC.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/25.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXCheckVCType) {
    ZXCheckVC4Regist,
    ZXCheckVC4ResetPassword
};

@interface ZXCheckVerificationCodeVC : UIViewController

@property (nonatomic, copy) NSString *phoneCode;
@property (nonatomic, assign) ZXCheckVCType type;

@end
