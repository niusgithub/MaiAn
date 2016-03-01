//
//  ZXBasicDynamicTVC.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/10.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXBasicDynamicTVC.h"
#import "ZXButtomCell.h"

#import "ZXCommon.h"
#import "UIColor+ZX.h"

#import "MJRefresh.h"

@interface ZXBasicDynamicTVC ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;
@property (nonatomic, strong) NSDate *lastRefreshTime;

@end

@implementation ZXBasicDynamicTVC

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _serverResponseObjects = [NSMutableArray new];
        _page = 0;
        //_needRefreshAnimation = YES;
        //_shouldFetchDataAfterLoaded = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"ZXBasicDynamicTVC");
    
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 设置背景色
    UIView *view = [[UIView alloc] initWithFrame:self.tableView.frame];
    [view setBackgroundColor:[UIColor themeBGColor]];
    [self.tableView setBackgroundView:view];
    
    
    // 下拉刷新
    if (_needHeaderRefresher) {
        self.tableView.mj_header = ({
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
            header.lastUpdatedTimeLabel.hidden = YES;
            header.stateLabel.hidden = YES;
            header;
        });
    }
    
    // 自动刷新
    if (_needAutoRefresh) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
        _lastRefreshTime = [_userDefaults objectForKey:_kLastRefreshTime];
        
        if (!_lastRefreshTime) {
            _lastRefreshTime = [NSDate date];
            [_userDefaults setObject:_lastRefreshTime forKey:_kLastRefreshTime];
        }
    }
    
    // 上拉加载
//    _buttomCell = [[ZXButtomCell alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 44)];
//    [_buttomCell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fetchMore)]];
//    self.tableView.tableFooterView = _buttomCell;
    
    //if (!_shouldFetchDataAfterLoaded) {return;}
}


#pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _serverResponseObjects.count;
}


#pragma mark - 刷新

- (void)refresh {
    NSLog(@"下拉刷新");
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        _manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
//        [self fetchObjectsOnPage:0 refresh:YES];
//    });
    
    //刷新时，增加另外的网络请求功能
//    if (self.anotherNetWorking) {
//        self.anotherNetWorking();
//    }
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
}


#pragma mark - 上拉加载更多

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height - 150)) {
//        [self fetchMore];
//    }
//}
//
//- (void)fetchMore {
//    NSLog(@"加载更多");
//    if (!_buttomCell.shouldResponseToTouch) {return;}
//    
//    _buttomCell.type = ZXButtomCellTypeLoading;
//    //_manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
//    //[self fetchObjectsOnPage:++_page refresh:NO];
//}

@end
