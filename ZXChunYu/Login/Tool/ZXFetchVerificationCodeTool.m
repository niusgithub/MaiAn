//
//  ZXFetchVerificationCodeTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/27.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXFetchVerificationCodeTool.h"
#import <SMS_SDK/SMSSDK.h>
#import "MBProgressHUD+MJ.h"
#import "ZXChunYuAPI.h"
#import "ZXHTTPTool.h"

@implementation ZXFetchVerificationCodeTool

+ (void)fetchVerificationCodeByPhoneCode:(NSString *)phoneCode successBlock:(void(^)(void))successBlock {
    
    // 默认为国内号码
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneCode zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            if (successBlock) {
                [MBProgressHUD showSuccess:@"验证码已成功发送，请耐心等待。"];
                successBlock();
            }
        } else {
            NSString *messageStr = [NSString stringWithFormat:@"%zidescription",error.code];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                            message:NSLocalizedString(messageStr, nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

+ (void)comfirmVerificationCodeWithVerifyCode:(NSString *)verifyCode phoneCode:(NSString *)phoneCode successBlock:(void(^)())successBlock {
    [SMSSDK  commitVerificationCode:verifyCode phoneNumber:phoneCode zone:@"86" result:^(NSError *error) {
        if (!error) {
            [MBProgressHUD showSuccess:@"验证成功"];
            successBlock();
//            NSLog(@"验证成功");
//            NSString* str = [NSString stringWithFormat:NSLocalizedString(@"verifycoderightmsg", nil)];
//            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"verifycoderighttitle", nil)
//                                                            message:str
//                                                           delegate:self
//                                                  cancelButtonTitle:NSLocalizedString(@"sure", nil)
//                                                  otherButtonTitles:nil, nil];
//            [alert show];
        } else {
            NSLog(@"验证失败");
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"verifycodeerrortitle", nil)
                                                            message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"commitVerificationCode"]]
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                  otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

+ (void)hasPhoneCodeRegistered:(NSString *)phoneCode successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    NSDictionary *param = @{
                            @"username" : phoneCode
                            };
    
    [ZXHTTPTool GET:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:isUserRegistered] params:param success:^(id responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
