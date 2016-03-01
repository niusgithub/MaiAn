//
//  ZXAdTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXAdTool : NSObject

+ (void)getAdsWithSuccessBlock:(void(^)(id responseObject))successBlock failureBlock:(void(^)(NSError *error))failureBlock;

@end
