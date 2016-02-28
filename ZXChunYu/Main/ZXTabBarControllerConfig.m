//
//  ZXTabBarControllerConfig.m
//  ZXChunYu
//
//  Created by yunmu on 15/11/23.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXTabBarControllerConfig.h"
#import "ZXCommon.h"
#import "UIColor+ZX.h"

//View Controllers
#import "ZXHomeTVC.h"
#import "ZXProfileTVC.h"
#import "ZXSwipableViewController.h"
#import "ZXHealthNewsTVC.h"
#import "ZXTreatmentsVC.h"

@interface ZXTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarcontroller;

@end


@implementation ZXTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (!_tabBarcontroller) {
        // 主页
        ZXHomeTVC *home = [[ZXHomeTVC alloc] init];
        home.view.backgroundColor = [UIColor themeBGColor];
        UIViewController *homeNC = [[UINavigationController alloc] initWithRootViewController:home];
        
        // 健康记录
        UIViewController *records = [[UIViewController alloc] init];
        records.view.backgroundColor = [UIColor grayColor];
        UIViewController *recordsNC = [[UINavigationController alloc] initWithRootViewController:records];
        
        // 健康资讯
        ZXHealthNewsTVC *commonSenseHN = [[ZXHealthNewsTVC alloc] initWithHealthNewsType:ZXHealthNewsCommomSense];
        ZXHealthNewsTVC *symptomHN = [[ZXHealthNewsTVC alloc] initWithHealthNewsType:ZXHealthNewsSymoptom];
        ZXHealthNewsTVC *diagnosisHN = [[ZXHealthNewsTVC alloc] initWithHealthNewsType:ZXHealthNewsDiagnosis];
        ZXHealthNewsTVC *preventionHN = [[ZXHealthNewsTVC alloc] initWithHealthNewsType:ZXHealthNewsPrevention];
        
        commonSenseHN.needCache = YES;
        symptomHN.needCache = YES;
        diagnosisHN.needCache = YES;
        preventionHN.needCache = YES;
        
        ZXSwipableViewController *news = [[ZXSwipableViewController alloc] initWithTitle:@"健康资讯" andSubTitles:@[@"基本常识", @"临床症状", @"诊断治疗", @"预防保健"] andControllers:@[commonSenseHN, symptomHN, diagnosisHN, preventionHN] underTabbar:NO];
        UIViewController *newsNC = [[UINavigationController alloc] initWithRootViewController:news];
        
        // 健康产品
        ZXTreatmentsVC *goods = [[ZXTreatmentsVC alloc] init];
        UIViewController *goodsNC = [[UINavigationController alloc] initWithRootViewController:goods];
        
        // 个人中心
        ZXProfileTVC *profile = [[ZXProfileTVC alloc] init];
        //profile.view.backgroundColor = [UIColor purpleColor];
        UIViewController *profileNC = [[UINavigationController alloc] initWithRootViewController:profile];
        
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
        
        /*
         *
         在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
         *
         */
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[homeNC,
                                               /*recordsNC,*/
                                               newsNC,
                                               goodsNC,
                                               profileNC]];
        [[self class] customizeTabBarAppearance];
        
        _tabBarcontroller = tabBarController;
    }
    return _tabBarcontroller;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 *
 */
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *homeTabBarDict = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"tabbar_home",
                            CYLTabBarItemSelectedImage : @"tabbar_home_selected",
                            };
    NSDictionary *recordsTabBarDict = @{
                                     CYLTabBarItemTitle : @"健康记录",
                                     CYLTabBarItemImage : @"tabbar_records",
                                     CYLTabBarItemSelectedImage : @"tabbar_records_selected",
                                     };
    NSDictionary *newsTabBarDict = @{
                                        CYLTabBarItemTitle : @"健康资讯",
                                        CYLTabBarItemImage : @"tabbar_news",
                                        CYLTabBarItemSelectedImage : @"tabbar_news_selected",
                                        };
    NSDictionary *goodsTabBarDict = @{
                                        CYLTabBarItemTitle : @"健康产品",
                                        CYLTabBarItemImage : @"tabbar_goods",
                                        CYLTabBarItemSelectedImage : @"tabbar_goods_selected",
                                        };
    NSDictionary *profileTabBarDict = @{
                                        CYLTabBarItemTitle : @"个人中心",
                                        CYLTabBarItemImage : @"tabbar_profile",
                                        CYLTabBarItemSelectedImage :@"tabbar_profile_selected",
                                        };
    
    NSArray *tabBarItemsAttributes = @[
                                       homeTabBarDict,
                                       /*recordsTabBarDict,*/
                                       newsTabBarDict,
                                       goodsTabBarDict,
                                       profileTabBarDict
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
+ (void)customizeTabBarAppearance {
    
    //去除 TabBar 自带的顶部阴影
    //[[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = ZXGrayColor;
    
    // 选中状态下的的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor themeColor];
    
    // 设置文字属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // TabBar选中后的背景色
    //[[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:tabBarColorSelected forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width/5.0f, 49) withCornerRadius:0]];
    
    // set the bar background color
    // 设置背景图片
    // UITabBar *tabBarAppearance = [UITabBar appearance];
    // [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background_ios7"]];
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

@end




















