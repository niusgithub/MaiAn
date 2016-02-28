//
//  ZXNetworkStatusTool.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/19.
//  Copyright © 2016年 陈知行. All rights reserved.
//
//  基于AFNetworking

#import "ZXNetworkStatusTool.h"

#import "ZXCommon.h"

#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@implementation ZXNetworkStatusTool

- (void)startMonitor {
    // 监控网络
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                XZXLog(@"没有网络(断网)");
//FIXME:需要结合网络情况来判断是否向服务器发送请求
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                self.networkStatus = ZXNetworkStatusNotReachable;
                //[userDefaults setBool:NO forKey:@"hasNetwork"];
                break;
                
                // 断网重新联网后需要刷新断网期间数据
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                XZXLog(@"手机自带网络");
                self.networkStatus = ZXNetworkStatusWWAN;
                //[userDefaults setBool:YES forKey:@"hasNetwork"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                XZXLog(@"WiFi");
                self.networkStatus = ZXNetworkStatusWiFi;
                //[userDefaults setBool:YES forKey:@"hasNetwork"];
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
}

@end
