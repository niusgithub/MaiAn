//
//  ZXUserInfoTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXUserInfoTool.h"

#import "ZXMaiAnAPI.h"
#import "ZXHTTPTool.h"
#import "ZXUserInfo.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"

#import "YYModel.h"

#import "NSString+ZX.h"

@implementation ZXUserInfoTool

+ (void)getUserInfoWithSuccessBlock:(void(^)(id))successBlock
                       failureBlock:(void(^)(NSError *))failureBlock {
    
    ZXAccount *account = [ZXAccountTool shareAccount];
    
    // 根据uid获取用户信息
    NSDictionary *params = @{
                             @"uid" : account.uid,
                             };
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getUserInfoByUID] UID:account.uid KEY:account.key params:params success:^(id responseObj) {
        if (successBlock) {
                successBlock(responseObj);
            }
        } failure:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
}

+ (void)updateUserInfoWithUserInfo:(ZXUserInfo *)userInfo
                      successBlock:(void(^)(id))successBlock
                      failureBlock:(void(^)(NSError *))failureBlock {
    
    NSDictionary *params = @{
                             @"userInfo2" : [userInfo yy_modelToJSONString]
                             };
    
    ZXAccount *account = [ZXAccountTool shareAccount];
    
    [ZXHTTPTool POST:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:updateUserInfo]
                 UID:account.uid
                 KEY:account.key
              params:params
             success:^(id responseObj) {
                 if (successBlock) {
                     successBlock(responseObj);
                 }
             }
             failure:^(NSError * error) {
                 // [NSException raise:NSGenericException format:@"ZXLoginTool getLoginInfoWithParam ERR"];
                 if (failureBlock) {
                     failureBlock(error);
                 }
             }
     ];
}

@end
