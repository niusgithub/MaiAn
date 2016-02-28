//
//  ZXHealthNewsTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHealthNewsTool : NSObject

+ (void)getArticlesByType:(NSString *)typeString startNumber:(NSNumber *)startNum successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;

@end
