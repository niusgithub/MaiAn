//
//  ZXGetDocsTool.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/18.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXGetDocsTool : NSObject

+ (void)getDocsInfoWithParam:(NSObject *)params successBlock:(void(^)(id))successBlock failureBlock:(void(^)(NSError *))failureBlock;
@end
