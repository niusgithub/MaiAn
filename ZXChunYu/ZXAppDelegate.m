//
//  AppDelegate.m
//  ZXChunYu
//
//  Created by 陈知行 on 15/11/16.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXAppDelegate.h"
#import "ZXTabBarControllerConfig.h"
#import "ZXCommon.h"
#import "UIColor+ZX.h"

#import "ZXNetworkStatusTool.h"

#import <SMS_SDK/SMSSDK.h>  
#import <RongIMKit/RongIMKit.h>

@interface ZXAppDelegate ()

@end

@implementation ZXAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置主窗口,并设置跟控制器
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ZXTabBarControllerConfig *tabBarControllerConfig = [[ZXTabBarControllerConfig alloc] init];
    
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    // 设置界面
    [self customizeInterface];
    
    // SMS
    [SMSSDK registerApp:@"f1adcdff4476" withSecret:@"40466fd4cdc05b2a676b62bb32aed1c5"];
    
    // RongCloud
    //[[RCIM sharedRCIM] initWithAppKey:@"sfci50a7cbzii"];//z3v5yqkbvtcr0
    [[RCIM sharedRCIM] initWithAppKey:@"x18ywvqf80c3c"];
    
    ZXNetworkStatusTool *networkStatusTool = [[ZXNetworkStatusTool alloc] init];
    [networkStatusTool startMonitor];
    
    return YES;
}

- (void)customizeInterface {
    [self configureTabBarAppearance];
    [self configureNavigationBarAppearance];
}

- (void)configureTabBarAppearance {
    UITabBar *tabBarAppearance = [UITabBar appearance];
    
//    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    
    [tabBarAppearance setBackgroundImage:backgroundImage];
//    [tabBarAppearance setTranslucent:NO];
}

/**
 * 设置 NavigationBar样式
 */
- (void)configureNavigationBarAppearance {
    UINavigationBar *navAppearance = [UINavigationBar appearance];
    
//    UIImage *backgroundImage = nil;
      NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        // backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        textAttributes = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:21],
                           NSForegroundColorAttributeName:[UIColor whiteColor]
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        // backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont:[UIFont systemFontOfSize:21],
                           UITextAttributeTextColor:[UIColor whiteColor],
                           UITextAttributeTextShadowColor:[UIColor clearColor],
                           UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetZero]
                           };
#endif
    }
    //[navAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    //[navAppearance setTranslucent:NO];
    [navAppearance setBarTintColor:[UIColor themeColor]];
    [navAppearance setTitleTextAttributes:textAttributes];
    // item颜色
    [navAppearance setTintColor:[UIColor whiteColor]];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
