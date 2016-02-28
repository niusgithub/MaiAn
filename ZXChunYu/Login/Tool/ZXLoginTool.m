//
//  ZXLoginTool.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXLoginTool.h"
#import "ZXHTTPTool.h"
#import "ZXChunYuAPI.h"

@implementation ZXLoginTool

+ (void)getLoginInfoWithParam:(ZXLoginParams *)params successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    [ZXHTTPTool POST:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:LoginURL] params:params success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError * error) {
        // [NSException raise:NSGenericException format:@"ZXLoginTool getLoginInfoWithParam ERR"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)updateUserPasswordWithUsername:(NSString *)username newPassword:(NSString *)newPassword successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock {
    
    NSDictionary *params = @{
                            @"username" : username,
                            @"newPasswd" : newPassword
                            };
    
    [ZXHTTPTool POST:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:updateUserPwd] params:params success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError * error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)userRegistWithUsername:(NSString *)username password:(NSString *)password successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock {
    
    NSDictionary *params = @{
                             @"username" : username,
                             @"passwd" : password
                             };
    
    [ZXHTTPTool POST:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:userRegist] params:params success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError * error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
