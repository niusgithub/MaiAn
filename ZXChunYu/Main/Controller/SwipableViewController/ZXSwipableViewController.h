//
//  ZXSwipableViewController.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZXTitleBarView.h"
#import "ZXHorizonalTableViewController.h"

@interface ZXSwipableViewController : UIViewController

@property (nonatomic, strong) ZXHorizonalTableViewController *viewPager;
@property (nonatomic, strong) ZXTitleBarView *titleBar;

- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers underTabbar:(BOOL)underTabbar;
- (instancetype)initWithTitle:(NSString *)title andSubTitles:(NSArray *)subTitles andControllers:(NSArray *)controllers;
- (void)scrollToViewAtIndex:(NSUInteger)index;

@end
