//
//  ZXGetDocsTool.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/18.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXGetDocsTool.h"
#import "ZXHTTPTool.h"
#import "ZXMaiAnAPI.h"
#import "ZXAccount.h"

@implementation ZXGetDocsTool

+ (void)getDocsInfoWithParam:(NSObject *)params
                successBlock:(void(^)(id))successBlock
                failureBlock:(void(^)(NSError *))failureBlock {
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getDocsURL]
             params:params
            success:^(id responseObj) {
                if (successBlock) {
                    successBlock(responseObj);
                }
            } failure:^(NSError *error) {
                // [NSException raise:NSGenericException format:@"ZXGetDocsTool getDocsInfoWithParam ERR"];
                if (failureBlock) {
                    failureBlock(error);
                }
            }
     ];
}

+ (void)getUserFollowDoctorWithAccount:(ZXAccount *)accout
                           startNumber:(NSNumber *)startNum
                          successBlock:(void(^)(id responseObject))successBlock
                          failureBlock:(void(^)(NSError *error))failureBlock {
    
    NSDictionary *params = @{
                             @"uid" : accout.uid,
                             @"start_num" : startNum
                             };
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getFocusedDoc]
                UID:accout.uid
                KEY:accout.key
             params:params success:^(id responseObj) {
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

@end
