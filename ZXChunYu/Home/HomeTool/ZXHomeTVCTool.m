//
//  ZXHomeTVCTool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXHomeTVCTool.h"
#import "ZXHTTPTool.h"
#import "ZXMaiAnAPI.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXFreeQuestion.h"

#import "YYModel.h"

@implementation ZXHomeTVCTool

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

+ (void)quickFreeQA:(NSString *)content successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock {
    
    ZXAccount *account = [ZXAccountTool shareAccount];
    
    ZXFreeQuestion *question = [[ZXFreeQuestion alloc] init];
    question.uid = account.uid;
    question.content = content;
    
    NSDictionary *params = @{
                             @"freeQuestion" : [question yy_modelToJSONString]
                             };
    
    [ZXHTTPTool POST:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:freeQuestion]
                 UID:account.uid
                 KEY:account.key
              params:params
             success:^(id responseObj) {
                 if (successBlock) {
                     successBlock(responseObj);
                 }
             } failure:^(NSError *error) {
                 if (failureBlock) {
                     failureBlock(error);
                 }
             }
     ];
}

+ (void)quickChargeQA:(NSString *)content
         successBlock:(void(^)(id responseObject))successBlock
         failureBlock:(void(^)(NSError *error))failureBlock {
    
}

@end
