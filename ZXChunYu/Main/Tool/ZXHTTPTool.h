//
//  ZXHTTPTool.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/16.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHTTPTool : NSObject

+ (void)POST:(NSString *)URL params:(NSObject *)paramsObj success:(void(^)(id))success failure:(void(^)(NSError *))failure;

+ (void)POST:(NSString *)URL
         UID:(NSString *)uid
         KEY:(NSString *)key
      params:(NSObject *)paramsObj
     success:(void(^)(id responseObj))success
     failure:(void(^)(NSError *err))failure;

+ (void)GET:(NSString *)URL params:(NSObject *)paramsObj success:(void(^)(id))success failure:(void(^)(NSError *))failure;

+ (void)GET:(NSString *)URL
        UID:(NSString *)uid
        KEY:(NSString *)key
     params:(NSObject *)paramsObj
    success:(void(^)(id responseObj))success
    failure:(void(^)(NSError *err))failure;

//+ (void)UploadImageWithURL:(NSString *)URL params:(NSObject *)paramsObj imageName:(NSString *)imageName imageData:(NSData *)imageData success:(void(^)(id))success failure:(void(^)(NSError *))failure;

+ (void)UploadImageWithURL:(NSString *)URL
                       UID:(NSString *)uid
                       KEY:(NSString *)key
                    params:(NSObject *)paramsObj
                 imageName:(NSString *)imageName
                 imageData:(NSData *)imageData
                   success:(void(^)(id responseObj))success
                   failure:(void(^)(NSError *err))failure;

@end
