//
//  ZXUserInfoTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXUserInfoTool.h"

#import "ZXChunYuAPI.h"
#import "ZXHTTPTool.h"
#import "ZXUserInfo.h"

#import "YYModel.h"

#import "NSString+ZX.h"

@implementation ZXUserInfoTool

+ (void)getUserInfoWithUID:(NSString *)uid successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    // 根据uid获取用户信息
    NSDictionary *params = @{
                             @"uid" : uid,
                             };
    
    [ZXHTTPTool GET:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:getUserInfoByUID] params:params success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)updateUserInfoWithUserInfo:(ZXUserInfo *)userInfo successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    NSDictionary *params = @{
                             @"userInfo2" : [userInfo yy_modelToJSONString],
                             };

    [ZXHTTPTool POST:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:updateUserInfo] params:params success:^(id responseObj) {
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

@end
