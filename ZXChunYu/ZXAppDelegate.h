//
//  ZXAppDelegate.h
//  ZXChunYu
//
//  Created by 陈知行 on 15/11/16.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@interface ZXAppDelegate : UIResponder <UIApplicationDelegate, RCIMUserInfoDataSource, RCIMConnectionStatusDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

