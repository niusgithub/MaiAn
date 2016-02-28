//
//  ZXSearch4DocTool.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/7.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXSearch4DocTool : NSObject

+ (void)getDoctorWithName:(NSString *)name andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;
+ (void)getDoctorWithArea:(NSString *)area andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;
+ (void)getDoctorWithTitle:(NSString *)title andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;
@end
