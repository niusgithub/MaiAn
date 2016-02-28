//
//  ZXSearch4HosTool.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/21.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXSearch4HosTool : NSObject

+ (void)getHospitalsByNumber:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;
+ (void)getHospitalsByName:(NSString *)name andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;
+ (void)getHospitalsByArea:(NSString *)area andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;
+ (void)getHospitalsByTitle:(NSString *)title andStartNum:(NSNumber *)number successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;
@end
