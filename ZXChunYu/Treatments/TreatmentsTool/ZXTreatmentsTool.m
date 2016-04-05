//
//  ZXTreatmentsTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/28.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXTreatmentsTool.h"
#import "ZXHTTPTool.h"
#import "ZXMaiAnAPI.h"

@implementation ZXTreatmentsTool

+ (void)getGoodsByStartNumber:(NSNumber *)startNum successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock {
    // 参数 start_num=0
    NSDictionary *params = @{
                             @"start_num" : startNum
                             };
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getGoods] params:params success:^(id responseObj) {
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
