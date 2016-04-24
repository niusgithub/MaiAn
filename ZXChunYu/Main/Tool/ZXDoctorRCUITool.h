//
//  ZXDoctorRCUITool.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/24.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMLib/RCUserInfo.h>

@interface ZXDoctorRCUITool : NSObject

+ (void)writeDoctorRCUI:(NSString *)did docInfo:(RCUserInfo *)docInfo;
+ (void)removeDoctorRCUI:(NSString *)did;
+ (RCUserInfo *)readDoctorRCUI:(NSString *)did;

+ (void)clearDoctorRCUI;

@end
