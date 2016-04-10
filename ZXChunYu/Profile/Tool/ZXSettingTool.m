//
//  ZXSettingTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/9.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXSettingTool.h"

#import "ZXMaiAnAPI.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXHTTPTool.h"

@implementation ZXSettingTool

+ (void)changeUserPassword:(NSString *)newPassword
              successBlock:(void(^)(id responseObject))successBlock
              failureBlock:(void(^)(NSError *error))failureBlock {
    ZXAccount *accout = [ZXAccountTool shareAccount];
    
    NSDictionary *params = @{
                             @"uid" : accout.uid,
                             @"newPasswd" : newPassword
                             };
    
    [ZXHTTPTool POST:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:changePwd]
                 UID:accout.uid
                 KEY:accout.key
              params:params
             success:^(id responseObj) {
                 if (successBlock) {
                     successBlock(responseObj);
                 }
             } failure:^(NSError *err) {
                 if (failureBlock) {
                     failureBlock(err);
                 }
             }];
}

@end
