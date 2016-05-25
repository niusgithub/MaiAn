//
//  ZXRCIMManager.h
//
//  Created by 陈知行 on 16/4/29.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

@protocol ZXRCIMManagerDelegate <NSObject>

- (void)receiveNewMsg;

@end

@interface ZXRCIMManager : NSObject <RCIMReceiveMessageDelegate>

@property (nonatomic, assign) NSInteger messageCount;
@property (nonatomic, weak) id<ZXRCIMManagerDelegate> msgDelegate;

+ (instancetype)sharedManager;

@end
