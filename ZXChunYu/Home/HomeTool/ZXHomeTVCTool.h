//
//  ZXHomeTVCTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHomeTVCTool : NSObject

/**
 *  获取广告
 *
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)getAdsWithSuccessBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;

/**
 *  @author 陈知行, 16-04-25 09:04:15
 *
 *  快速提问(免费)
 *
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)quickFreeQA:(NSString *)content
       successBlock:(void(^)(id responseObject))successBlock
       failureBlock:(void(^)(NSError *error))failureBlock;

/**
 *  @author 陈知行, 16-04-25 09:04:15
 *
 *  快速提问(付费)
 *
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)quickChargeQA:(NSString *)content
         successBlock:(void(^)(id responseObject))successBlock
         failureBlock:(void(^)(NSError *error))failureBlock;

@end
