//
//  ZXDocClinicTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXAccount;

@interface ZXDocClinicTool : NSObject

/**
 *  关注医生
 *
 *  @param accout       accout
 *  @param did          医生id
 *  @param successBlcok successBlcok
 *  @param failureBlock failureBlock
 */
+ (void)followDoctorWithAccout:(ZXAccount *)accout
                           DID:(NSString *)did
                  successBlock:(void(^)(id responseObject))successBlock
                  failureBlock:(void(^)(NSError *error))failureBlock;

/**
 *  取消关注医生
 *
 *  @param accout       accout
 *  @param did          did
 *  @param successBlcok successBlcok
 *  @param failureBlock failureBlock
 */
+ (void)cancelFollowDoctorWithAccout:(ZXAccount *)accout
                                 DID:(NSString *)did
                        successBlock:(void(^)(id responseObject))successBlcok
                        failureBlock:(void(^)(NSError *error))failureBlock;

@end
