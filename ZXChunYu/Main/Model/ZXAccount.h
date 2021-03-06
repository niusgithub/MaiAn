//
//  ZXAccount.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMLib/RCUserInfo.h>

@interface ZXAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *passwd;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *u_portrait_path;
@property (nonatomic, copy) NSString *key;

@property (nonatomic, strong) RCUserInfo *rcUserInfo;

// 关注的医生的did
@property (nonatomic, strong) NSMutableSet *mDocIDs;
@end
