//
//  ZXHealthNewsTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXHealthNewsTool.h"
#import "ZXHTTPTool.h"
#import "ZXChunYuAPI.h"
#import "NSString+ZX.h"

@implementation ZXHealthNewsTool

+ (void)getArticlesByType:(NSString *)typeString startNumber:(NSNumber *)startNum successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    // 参数 type=基本常识&start_num=0
    NSDictionary *params = @{
                             @"type" : typeString,
                             @"start_num" : startNum
                             };
    
    [ZXHTTPTool GET:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:getArticlesByType] params:params success:^(id responseObj) {
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
