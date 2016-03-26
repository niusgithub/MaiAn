//
//  ZXGetDocsTool.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/18.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXAccount;

@interface ZXGetDocsTool : NSObject

+ (void)getDocsInfoWithParam:(NSObject *)params
                successBlock:(void(^)(id))successBlock
                failureBlock:(void(^)(NSError *))failureBlock;

+ (void)getUserFollowDoctorWithAccount:(ZXAccount *)accout
                           startNumber:(NSNumber *)startNum
                          successBlock:(void(^)(id responseObject))successBlock
                          failureBlock:(void(^)(NSError *error))failureBlock;

@end
