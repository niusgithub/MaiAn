//
//  ZXSearch4DocTool.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/7.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXSearch4DocTool.h"
#import "ZXHTTPTool.h"
#import "ZXChunYuAPI.h"

@implementation ZXSearch4DocTool

/**
 *  根据医生姓名查找医生
 *
 *  @param name         医生姓名
 *  @param number       起始ID
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)getDoctorWithName:(NSString *)name andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    // 根据姓名查找医生的参数
    NSDictionary *s4dParams = @{
                                @"dc_name" : name,
                                @"start_num" : number
                                };
    
    [ZXHTTPTool GET:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:getDocByNameURL] params:s4dParams success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

//dc_area=湖北武汉&start_num=0
/**
 *  根据地区查找医生
 *
 *  @param area         地区名
 *  @param number       起始ID
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)getDoctorWithArea:(NSString *)area andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    // 根据地区查找医生的参数
    NSDictionary *s4dParams = @{
                                @"dc_area" : area,
                                @"start_num" : number
                                };
    
    [ZXHTTPTool GET:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:getDocByAreaURL] params:s4dParams success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

// dc_title=主治医师&start_num=0
/**
 *  根据职称查找医生
 *
 *  @param title        医生职称
 *  @param number       起始ID
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)getDoctorWithTitle:(NSString *)title andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    // 根据职称查找医生的参数
    NSDictionary *s4dParams = @{
                                @"dc_title" : title,
                                @"start_num" : number
                                };
    
    [ZXHTTPTool GET:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:getDocByTitleURl] params:s4dParams success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
