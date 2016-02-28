//
//  ZXGetDocExtraInfo.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/30.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXGetDocExtraInfo.h"
#import "ZXHTTPTool.h"
#import "ZXChunYuAPI.h"

@implementation ZXGetDocExtraInfo
/**
 *  获取指定医生的粉丝数
 *
 *  @param DID          医生ID
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)getDoctorFollowerNumberWithDID:(NSString *)DID successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    [ZXHTTPTool GET:[NSString stringWithFormat:@"%@%@%lld", ZXChunYu_HTTP_REQUEST_PREFIX, getDocFollowerNumURL, [DID longLongValue]] params:nil success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        // [NSException raise:NSGenericException format:@"getDoctorFollowerNumberWithDID GET ERR"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

/**
 *  获取指定医生的服务人数
 *
 *  @param DID          医生ID
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)getDoctorServeNumberWithDID:(NSString *)DID successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    [ZXHTTPTool GET:[NSString stringWithFormat:@"%@%@%lld", ZXChunYu_HTTP_REQUEST_PREFIX, getDocServeNumURL, [DID longLongValue]] params:nil success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        // [NSException raise:NSGenericException format:@"getDoctorServeNumberWithDID GET ERR"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
