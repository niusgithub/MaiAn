//
//  ZXLoginTool.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXLoginParams.h"


//extern NSString *const ZXLogin_HTTPS_PREFIX;

@interface ZXLoginTool : NSObject
+ (void)getLoginInfoWithParam:(ZXLoginParams *)params successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;

+ (void)updateUserPasswordWithUsername:(NSString *)username newPassword:(NSString *)newPassword successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;

+ (void)userRegistWithUsername:(NSString *)username password:(NSString *)password successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;
@end
