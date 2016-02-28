//
//  ZXFetchVerificationCodeTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/27.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXFetchVerificationCodeTool : NSObject

+ (void)fetchVerificationCodeByPhoneCode:(NSString *)phoneCode successBlock:(void(^)(void))successBlock;
+ (void)comfirmVerificationCodeWithVerifyCode:(NSString *)verifyCode phoneCode:(NSString *)phoneCode successBlock:(void(^)())successBlock;
+ (void)hasPhoneCodeRegistered:(NSString *)phoneCode successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;

@end
