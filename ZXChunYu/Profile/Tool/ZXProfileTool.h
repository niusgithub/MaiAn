//
//  ZXProfileTool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/9.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
+ (void)UploadAvatarWithUID:(NSString *)uid imageName:(NSString *)imageName imageData:(NSData *)imageData success:(void(^)(id))success failure:(void(^)(NSError *))failure;

@end
