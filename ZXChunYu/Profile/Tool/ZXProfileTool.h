//
//  ZXProfileTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/9.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZXAccount;

@interface ZXProfileTool : NSObject

/**
 *  上传头像
 *
 *  @param uid       uid
 *  @param imageName imageName
 *  @param imageData imageData
 *  @param success   success block
 *  @param failure   failure block
 */
+ (void)UploadAvatarWithAccount:(ZXAccount *)account
                      imageName:(NSString *)imageName
                      imageData:(NSData *)imageData
                   successBlock:(void(^)(id responseObject))successBlock
                   failureBlock:(void(^)(NSError *error))failureBlock;
/**
 *  获取用户头像地址
 *
 *  @param account account
 */
+ (void)getUserPortraitByAccount:(ZXAccount *)account
                    successBlock:(void(^)(id responseObject))successBlock
                    failureBlock:(void(^)(NSError *error))failureBlock;

@end
