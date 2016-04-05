//
//  ZXGetDocComments.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/5.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXGetDocComments.h"
#import "ZXHTTPTool.h"
#import "ZXMaiAnAPI.h"

@implementation ZXGetDocComments

/**
 *  获取指定医生的评论
 *
 *  @param DID          医生ID
 *  @param successBlock successBlock description
 *  @param failureBlock failureBlock description
 */
+ (void)getDoctorCommentsWithDID:(NSString *)DID
                        startNum:(NSNumber *)startNum
                    successBlock:(void(^)(id))successBlock
                    failureBlock:(void(^)(NSError *))failureBlock {
    
    NSDictionary *params = @{
                             @"did" : DID,
                             @"start_num" : startNum
                             };
    
    [ZXHTTPTool GET:[ZXMaiAn_HTTP_REQUEST_PREFIX stringByAppendingString:getDocCommentsURL]
             params:params success:^(id responseObj) {
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
