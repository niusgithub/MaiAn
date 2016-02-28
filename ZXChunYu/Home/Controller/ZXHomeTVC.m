//
//  ZXHomeTVC.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/4.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXHomeTVC.h"
#import "ZXTableViewGroup.h"
#import "ZXTableViewItem.h"
#import "ZXHomeAdView.h"
#import "ZXSearch4DocTVC.h"
#import "ZXSearch4HosTVC.h"
#import "ZXRDTableViewCell.h"
#import "ZXDocClinicTVC.h"

#import <SafariServices/SafariServices.h>

#import "ZXDoctor.h"

#import "ZXGetDocsTool.h"
#import "ZXGetDocExtraInfo.h"

#import "ZXChunYuAPI.h"
#import "ZXCommon.h"

#import "YYModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ZXHomeTVC ()
@property (nonatomic, strong) NSMutableArray *recommendedDoctors;
@end

@implementation ZXHomeTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 获取默认推荐医生(只要5个)
    [self getDocs];
    
    [self.tableView registerNib:[UINib nibWithNibName:kRDTableCellNibName bundle:nil] forCellReuseIdentifier:kRDCellIdentifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    
    [self configureGroups];
}


#pragma mark - init

- (NSMutableArray *)recommendedDoctors {
    if (!_recommendedDoctors) {
        _recommendedDoctors = [[NSMutableArray alloc] init];
    }
    return _recommendedDoctors;
}

/**
 *  联网请求医生数据（需要封装离线数据）
 */
- (void)getDocs {
    //  判断是否有离线数据

    
    // 没有离线数据，联网请求
    
    //!!!!
    [self.recommendedDoctors removeAllObjects];
    
    [ZXGetDocsTool getDocsInfoWithParam:nil successBlock:^(id responseObject) {
        //NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //NSLog(@"getDocs_responseObject:%@",rStr);
    
        NSDictionary *docInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        for (NSDictionary *docDict in docInfoJson) {
            @autoreleasepool {
                ZXDoctor *doc = [ZXDoctor yy_modelWithDictionary:docDict];
                [self.recommendedDoctors addObject:doc];
            }
        }
        [self.tableView reloadData];
//FIXME:此处有多次刷新的动画效果
        //[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"getDocs_ERR:%@",error);
    }];
}


#pragma mark - Group

/**
 *  初始化模型数据
 */
- (void)configureGroups {
    [self configureMainGroup];
    [self configureAdGroup];
    
    [self configureDocGroup];
}

- (void)configureMainGroup {
    // 创建组
    ZXTableViewGroup *group = [ZXTableViewGroup group];
    [self.groups addObject:group];
    
    // 设置数据
    // group.header = @""
    
    // 设置组的数据
    // 快速提问
    ZXTableViewItem *question = [ZXTableViewItem itemWithType:ZXTableViewCellTypeArrow title:@"快速提问" icon:@"question"];
    question.subTitle = @"描述症状 快速解答";
    
    // 找医生cell
    ZXTableViewItem *search4Doc = [ZXTableViewItem itemWithType:ZXTableViewCellTypeArrow title:@"找医生" icon:@"doctor"];
    search4Doc.subTitle = @"咨询、预约指定医生";
    // search4Doc.destVCClass = [ZXSearch4DocTVC class];
    
    // 找医院
    ZXTableViewItem *search4Hos = [ZXTableViewItem itemWithType:ZXTableViewCellTypeArrow title:@"找医院" icon:@"hospital"];
    search4Hos.subTitle = @"附近医院";
    
    // 自我评估
    ZXTableViewItem *selfCheck = [ZXTableViewItem itemWithType:ZXTableViewCellTypeArrow title:@"自我评估" icon:@"selfCheck"];
    selfCheck.subTitle = @"帮您判断身体的不适";
    
    group.items = @[question, search4Doc, search4Hos, selfCheck];
}

/**
 *  广告条
 */
- (void)configureAdGroup {
    // 创建组
    ZXTableViewGroup *group = [ZXTableViewGroup group];
    [self.groups addObject:group];
    
    group.items = @[];
}

/**
 *  推荐医生
 */
- (void)configureDocGroup {
    
    // 创建组
    ZXTableViewGroup *group = [ZXTableViewGroup group];
    [self.groups addObject:group];
}


#pragma mark - TableView DataSource

/**
 *  推荐医生的cell
 *
 *  @param tableView tableView description
 *  @param indexPath indexPath description
 *
 *  @return return value description
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    } else {
        ZXRDTableViewCell *cell = (ZXRDTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kRDCellIdentifier forIndexPath:indexPath];
        
        if (self.recommendedDoctors.count > 0) {
            ZXDoctor *doc = self.recommendedDoctors[indexPath.row];
            
            //粉丝数
            [ZXGetDocExtraInfo getDoctorFollowerNumberWithDID:doc.did successBlock:^(id responseObject) {
//                NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                NSLog(@"followerNum:%@",rStr);
                NSDictionary *followerNum = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                // followerNum[@"num"] 类型为NSNumber 可以打印 不能赋值给NSString
                doc.followerNum = [followerNum[@"num"] stringValue];
            } failureBlock:^(NSError *error) {
                NSLog(@"getDoctorExtraInfo--followerNum ERR:%@",error);
            }];
            
            //服务人数
            [ZXGetDocExtraInfo getDoctorServeNumberWithDID:doc.did successBlock:^(id responseObject) {
//                NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                NSLog(@"serveNum:%@",rStr);
                NSDictionary *serveNum = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                // serveNum[@"num"] 类型为NSNumber 可以打印 不能赋值给NSString
                doc.serveNum = [serveNum[@"num"] stringValue];
            } failureBlock:^(NSError *error) {
                NSLog(@"getDoctorExtraInfo--serveNum ERR:%@",error);
            }];

            [cell configureRDCellWithDoctor:doc];
        }
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section != 2) {
        return [super tableView:tableView numberOfRowsInSection:section];
    } else {
        if (self.recommendedDoctors.count > 0) {
            return 5;
        }
        return 0;
    }
}

/**
 *  广告条高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 130;
    }
    return 0;
}

/**
 *  替换header，变为广告条
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        ZXHomeAdView *view = [[ZXHomeAdView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 130)];
        return view;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60;
    }
    return kRDTableCellHeight;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return kRDTableCellHeight;
//}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 1: {
                ZXSearch4DocTVC *tvc = [[ZXSearch4DocTVC alloc] init];
                tvc.recommendedDoctors = [self.recommendedDoctors mutableCopy];
                [self.navigationController pushViewController:tvc animated:YES];
            }
                break;
                
            case 2: {
                ZXSearch4HosTVC *tvc = [[ZXSearch4HosTVC alloc] init];
                [self.navigationController pushViewController:tvc animated:YES];
            }
                break;
                
            case 3: {
                NSString *selfCheckURL = @"http://114.215.136.156/html/jmqz_level/jmqz_djpd.html";
                if (System_Version >= 9.0) {
                    SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:selfCheckURL]  entersReaderIfAvailable:YES];
                    [self presentViewController:safariViewController animated:YES completion:nil];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:selfCheckURL]];
                }
            }
                break;
        }
    }
    
    if (indexPath.section == 2) {
        // 打开对应的医生的诊所
        ZXDoctor *doc = self.recommendedDoctors[indexPath.row];
        ZXDocClinicTVC *vc = [[ZXDocClinicTVC alloc] initClinicWithDoctor:doc];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
