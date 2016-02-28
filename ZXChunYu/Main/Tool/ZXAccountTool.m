//
//  ZXAccountTool.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#define kAccountFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "ZXAccountTool.h"

@implementation ZXAccountTool

+ (void)saveAccount:(ZXAccount *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountFilePath];
}

+ (ZXAccount *)shareAccount {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFilePath];
}

+ (BOOL)removeAccount {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL result = [defaultManager removeItemAtPath:kAccountFilePath error:&error];
    if (!result) {
        NSLog(@"删除帐户文件失败:%@", error);
    }
    return result;
}

@end
