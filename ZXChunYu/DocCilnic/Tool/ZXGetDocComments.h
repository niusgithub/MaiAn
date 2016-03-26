//
//  ZXGetDocComments.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/5.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXGetDocComments : NSObject

+ (void)getDoctorCommentsWithDID:(NSString *)DID
                        startNum:(NSNumber *)startNum
                    successBlock:(void(^)(id))successBlock
                    failureBlock:(void(^)(NSError *))failureBlock;

@end
