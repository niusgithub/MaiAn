//
//  ZXUserInfoTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

@class ZXUserInfo, ZXAccount;

#import <Foundation/Foundation.h>

@interface ZXUserInfoTool : NSObject

+ (void)getUserInfoWithSuccessBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;

+ (void)updateUserInfoWithUserInfo:(ZXUserInfo *)userInfo successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;

@end
