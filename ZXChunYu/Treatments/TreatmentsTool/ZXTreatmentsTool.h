//
//  ZXTreatmentsTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/28.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXTreatmentsTool : NSObject

+ (void)getGoodsByStartNumber:(NSNumber *)startNum successBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;

@end
