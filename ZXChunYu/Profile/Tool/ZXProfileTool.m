//
//  ZXProfileTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/9.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXProfileTool.h"
#import "ZXHTTPTool.h"

#import "ZXChunYuAPI.h"

@implementation ZXProfileTool

+ (void)UploadAvatarWithUID:(NSString *)uid imageName:(NSString *)imageName imageData:(NSData *)imageData success:(void(^)(id))success failure:(void(^)(NSError *))failure {
    
    NSDictionary *imageParam = @{
                                 @"uid" : uid
                                 };
    
    [ZXHTTPTool UploadImageWithURL:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:uploadUserAvatar] params:imageParam imageName:imageName imageData:imageData success:^(id reponseObj) {
        
    } failure:^(NSError *error) {
        
    }];
}

@end
