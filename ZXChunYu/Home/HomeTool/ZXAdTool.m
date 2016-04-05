//
//  ZXAdTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXAdTool.h"
#import "ZXHTTPTool.h"
#import "ZXMaiAnAPI.h"

@implementation ZXAdTool

+ (void)getAdsWithSuccessBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock {
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getAds] params:nil success:^(id responseObj) {
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
