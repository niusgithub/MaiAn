//
//  ZXGetDocExtraInfo.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/30.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXGetDocExtraInfo : NSObject

+ (void)getDoctorFollowerNumberWithDID:(NSString *)DID
                          successBlock:(void(^)(id))successBlock
                          failureBlock:(void(^)(NSError *))failureBlock;

+ (void)getDoctorServeNumberWithDID:(NSString *)DID
                       successBlock:(void(^)(id))successBlock
                       failureBlock:(void(^)(NSError *))failureBlock;

@end
