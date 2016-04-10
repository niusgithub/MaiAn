//
//  ZXSettingTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/9.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXSettingTool : NSObject

/**
 *  修改密码
 *
 *  @param newPassword  newPassword
 *  @param successBlock successBlock
 *  @param failureBlock failureBlock
 */
+ (void)changeUserPassword:(NSString *)newPassword
              successBlock:(void(^)(id responseObject))successBlock
              failureBlock:(void(^)(NSError *error))failureBlock;

@end
