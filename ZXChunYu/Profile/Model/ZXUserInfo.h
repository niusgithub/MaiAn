//
//  ZXUserInfo.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

@class ZXAccount;

#import <Foundation/Foundation.h>

@interface ZXUserInfo : NSObject

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *weight;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *sfz_num;
@property (nonatomic, copy) NSString *marital_status;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) ZXAccount *user;

@end
