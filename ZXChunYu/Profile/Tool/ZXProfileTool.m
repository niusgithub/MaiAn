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

#import "ZXChunYuAPI.h"

@implementation ZXProfileTool

+ (void)UploadAvatarWithAccount:(ZXAccount *)account imageName:(NSString *)imageName imageData:(NSData *)imageData success:(void(^)(id))success failure:(void(^)(NSError *))failure {
    
    NSDictionary *imageParam = @{
                                 @"uid" : account.uid
                                 };
    
    [ZXHTTPTool UploadImageWithURL:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:uploadUserAvatar]
                               UID:(NSString *)account.uid
                               KEY:(NSString *)account.key
                            params:imageParam
                         imageName:imageName
                         imageData:imageData
                           success:^(id reponseObj) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
