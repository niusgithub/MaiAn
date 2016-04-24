//
//  ZXDoctorRCUITool.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/24.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXDoctorRCUITool.h"

@implementation ZXDoctorRCUITool

static NSString* const docRCUIFileName = @"doctorRCUI.plist";

+ (void)writeDoctorRCUI:(NSString *)did docInfo:(RCUserInfo *)docInfo {
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:docRCUIFileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSMutableDictionary *docInfoDic;
    
    if ([manager fileExistsAtPath:filePath]) {
        docInfoDic = [[[NSMutableDictionary alloc] initWithContentsOfFile:filePath] mutableCopy];
    } else {
        [manager createFileAtPath:filePath contents:nil attributes:nil];
        docInfoDic = [[NSMutableDictionary alloc] init];
    }
    
    NSData *doctorInfoData = [NSKeyedArchiver archivedDataWithRootObject:docInfo];
    
    [docInfoDic setObject:doctorInfoData forKey:did];
    
    [docInfoDic writeToFile:filePath atomically:YES];
}

+ (void)removeDoctorRCUI:(NSString *)did {
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:docRCUIFileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSMutableDictionary *docInfoDic;
    
    if ([manager fileExistsAtPath:filePath]) {
        docInfoDic = [[[NSMutableDictionary alloc] initWithContentsOfFile:filePath] mutableCopy];
        [docInfoDic removeObjectForKey:did];
        [docInfoDic writeToFile:filePath atomically:YES];
    }
}

+ (RCUserInfo *)readDoctorRCUI:(NSString *)did {
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:docRCUIFileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSMutableDictionary *docInfoDic;
    
    if ([manager fileExistsAtPath:filePath]) {
        docInfoDic = [[[NSMutableDictionary alloc] initWithContentsOfFile:filePath] mutableCopy];
    } else {
        return nil;
    }
    
    RCUserInfo *docInfo = [NSKeyedUnarchiver unarchiveObjectWithData:[docInfoDic objectForKey:did]];
    
    return docInfo;
}


+ (void)clearDoctorRCUI {
}

@end
