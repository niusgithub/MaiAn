//
//  ZXGetDocsTool.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/18.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXGetDocsTool.h"
#import "ZXHTTPTool.h"
#import "ZXChunYuAPI.h"

@implementation ZXGetDocsTool
+ (void)getDocsInfoWithParam:(NSObject *)params successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock {
    [ZXHTTPTool GET:[ZXChunYu_HTTP_REQUEST_PREFIX stringByAppendingString:getDocsURL]  params:params success:^(id responseObj) {
        if (successBlock) {
            successBlock(responseObj);
        }
    } failure:^(NSError *error) {
        // [NSException raise:NSGenericException format:@"ZXGetDocsTool getDocsInfoWithParam ERR"];
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}
@end
