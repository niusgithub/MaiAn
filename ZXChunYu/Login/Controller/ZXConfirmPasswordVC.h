//
//  ZXConfirmPasswordVC.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/24.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZXConfirmPasswordVCType) {
    ZXConfirmPasswordVCReigst,
    ZXConfirmPasswordVCReset
};

@interface ZXConfirmPasswordVC : UIViewController

@property (nonatomic, copy) NSString *labelText;
@property (nonatomic, copy) NSString *placeholderText;
@property (nonatomic, copy) NSString *phoneCode;
@property (nonatomic, assign) ZXConfirmPasswordVCType type;

@property (nonatomic, copy) void (^buttonClick)();

@end
