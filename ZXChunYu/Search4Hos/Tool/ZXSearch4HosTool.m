//
//  ZXSearch4HosTool.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/21.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXSearch4HosTool.h"
#import "ZXHTTPTool.h"
#import "ZXMaiAnAPI.h"

@implementation ZXSearch4HosTool

+ (void)getHospitalsByNumber:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    // 参数
    NSDictionary *params = @{
                             @"start_num" : number
                             };
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getHosByNum] params:params success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)getHospitalsByName:(NSString *)name andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    // 根据名称查找医院的参数
    NSDictionary *s4hParams = @{
                                @"hs_name" : name,
                                @"start_num" : number
                                };
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getHosByName] params:s4hParams success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)getHospitalsByArea:(NSString *)area andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    
    // 根据地区查找医院的参数
    NSDictionary *s4hParams = @{
                                @"hs_area" : area,
                                @"start_num" : number
                                };
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getHosByArea] params:s4hParams success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)getHospitalsByTitle:(NSString *)title andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    // 根据地区查找医院的参数
    NSDictionary *s4hParams = @{
                                @"hs_title" : title,
                                @"start_num" : number
                                };
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getHosByTitle] params:s4hParams success:^(id responseObj) {
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
