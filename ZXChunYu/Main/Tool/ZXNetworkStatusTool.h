//
//  ZXNetworkStatusTool.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/19.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXNetworkStatusTool : NSObject

typedef NS_ENUM(NSInteger, ZXNetworkStatusType) {
    ZXNetworkStatusNotReachable,
    ZXNetworkStatusWWAN,
    ZXNetworkStatusWiFi,
};

@property (nonatomic, assign) ZXNetworkStatusType networkStatus;

- (void)startMonitor;

@end
