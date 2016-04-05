//
//  ZXProfileTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/9.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXProfileTool.h"
#import "ZXHTTPTool.h"
#import "ZXAccount.h"

#import "ZXMaiAnAPI.h"

@implementation ZXProfileTool

+ (void)UploadAvatarWithAccount:(ZXAccount *)account
                      imageName:(NSString *)imageName
                      imageData:(NSData *)imageData
                   successBlock:(void(^)(id responseObject))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock {
    
    NSDictionary *imageParam = @{
                                 @"uid" : account.uid
                                 };
    
    [ZXHTTPTool UploadImageWithURL:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:uploadUserAvatar]
                               UID:(NSString *)account.uid
                               KEY:(NSString *)account.key
                            params:imageParam
                         imageName:imageName
                         imageData:imageData
                           success:^(id reponseObj) {
                               if (successBlock) {
                                   successBlock(reponseObj);
                               }
                           } failure:^(NSError *err) {
                               if (failureBlock) {
                                   failureBlock(err);
                               }
                           }
     ];
}

+ (void)getUserPortraitByAccount:(ZXAccount *)account
                    successBlock:(void(^)(id responseObject))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock {
    
    NSDictionary *params = @{
                             @"uid" : account.uid
                             };
    
    [ZXHTTPTool POST:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getUserPortrait]
                 UID:account.uid
                 KEY:account.key
              params:params
             success:^(id responseObj) {
                 if (successBlock) {
                     successBlock(responseObj);
                 }
             } failure:^(NSError *err) {
                 if (failureBlock) {
                     failureBlock(err);
                 }
             }
     ];
}

@end
