//
//  ZXAccountTool.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZXAccount.h"

@interface ZXAccountTool : NSObject

/**
 *  存储账号
 *
 *  @param account 帐号
 */
+ (void)saveAccount:(ZXAccount *)account;

/**
 *  读取账号
 *
 *  @return 帐号实例
 */
+ (ZXAccount *)shareAccount;

+ (BOOL)removeAccount;

@end
