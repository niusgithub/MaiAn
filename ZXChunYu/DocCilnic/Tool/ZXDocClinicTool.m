//
//  ZXDocClinicTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXDocClinicTool.h"
#import "ZXAccount.h"
#import "ZXHTTPTool.h"
#import "ZXMaiAnAPI.h"

@implementation ZXDocClinicTool

+ (void)followDoctorWithAccout:(ZXAccount *)accout
                           DID:(NSString *)did
                  successBlock:(void(^)(id responseObject))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock {

    // 提交用户ID以及医生ID：
    // key：uid value：1；
    // key：did value:1
    
    NSDictionary *params = @{
                             @"uid" : accout.uid,
                             @"did" : did
                             };
    
    [ZXHTTPTool POST:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:followDoctor]
                 UID:accout.uid
                 KEY:accout.key
              params:params success:^(id responseObject) {
                  if (successBlock) {
                      successBlock(responseObject);
                  }
              }
             failure:^(NSError *error) {
                 if (failureBlock) {
                     failureBlock(error);
                 }
             }
     ];
}

+ (void)cancelFollowDoctorWithAccout:(ZXAccount *)accout
                                 DID:(NSString *)did
                        successBlock:(void(^)(id responseObject))successBlock
                        failureBlock:(void(^)(NSError *error))failureBlock {
    // 提交用户ID以及医生ID：
    // key：uid value：1；
    // key：did value:1
    
    NSDictionary *params = @{
                             @"uid" : accout.uid,
                             @"did" : did
                             };
    
    [ZXHTTPTool POST:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:cancelFollowDoctor]
                 UID:accout.uid
                 KEY:accout.key
              params:params success:^(id responseObject) {
                  if (successBlock) {
                      successBlock(responseObject);
                  }
              }
             failure:^(NSError *error) {
                 if (failureBlock) {
                     failureBlock(error);
                 }
             }
     ];    
}

@end

