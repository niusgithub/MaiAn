//
//  ZXBasicDynamicTVC.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/10.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXButtomCell;

@interface ZXBasicDynamicTVC : UITableViewController

@property (nonatomic, copy) void (^tableWillReload)(NSUInteger responseObjectsCount);
@property (nonatomic, copy) void (^didRefreshSucceed)();

//@property Class objClass;
@property (nonatomic, assign) BOOL needHeaderRefresher;
@property (nonatomic, assign) BOOL needFooterRefresher;

@property (nonatomic, assign) BOOL shouldFetchDataAfterLoaded;

@property (nonatomic, assign) BOOL needAutoRefresh;
@property (nonatomic, assign) BOOL needRefreshAnimation;
@property (nonatomic, assign) NSTimeInterval refreshInterval;
@property (nonatomic, copy) NSString *kLastRefreshTime;

@property (nonatomic, assign) BOOL needCache;

@property (nonatomic, strong) NSMutableArray *serverResponseObjects;
@property (nonatomic, assign) int allCount;

@property (nonatomic, strong) ZXButtomCell *buttomCell;
//@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) NSUInteger page;

@property (nonatomic, copy) void (^anotherNetWorking)();

//- (NSArray *)parseXML:(ONOXMLDocument *)xml;
- (void)fetchMore;
- (void)refresh;

@end
