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
#import "ZXInsetLabel.h"
#import "ZXHomeMainCell.h"

#import <SafariServices/SafariServices.h>

#import "ZXDoctor.h"
#import "ZXAd.h"

#import "ZXGetDocsTool.h"
#import "ZXGetDocExtraInfo.h"
#import "ZXAdTool.h"

#import "ZXChunYuAPI.h"
#import "ZXCommon.h"
#import "UIColor+ZX.h"

#import "YYModel.h"
#import <SDWebImage/UIImageView+WebCache.h>


#import "ZXDocClinicTool.h"
#import "ZXAccountTool.h"


const CGFloat kTitleCellHeight = 30;

@interface ZXHomeTVC () <ZXHomeAdViewDelegate>
@property (nonatomic, strong) NSMutableArray *recommendedDoctors;
@property (nonatomic, strong) NSMutableArray *ads;
@end

@implementation ZXHomeTVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"首页";
    
    [self.tableView registerNib:[UINib nibWithNibName:kRDTableCellNibName bundle:nil] forCellReuseIdentifier:kRDCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:kHomeMainCellNibName bundle:nil] forCellReuseIdentifier:kHomeMainCellID];
    
    // 获取默认推荐医生(只要5个)
    [self fetchDocsData];
    
    [self fetchAdsData];
    
    
    /*
    // 添加成功返回Map<"msg", "add focus success">
    // 添加失败返回Map("msg", "add talk fail")
    [ZXDocClinicTool followDoctorWithAccout:[ZXAccountTool shareAccount] DID:@"1000000046"
                               successBlock:^(id responseObject) {
                                   NSDictionary *resonpseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                                   if ([resonpseDict[@"msg"] isEqualToString:@"add focus success"]) {
                                       //[MBProgressHUD showSuccess:@"修改成功"];
                                       NSLog(@"关注成功");
                                   } else if ([resonpseDict[@"msg"] isEqualToString:@"add talk fail"]) {
                                       NSLog(@"关注失败");
                                   }
                               }
                               failureBlock:^(NSError *error) {
                                   NSLog(@"Follow Doctor ERR:%@",error);
                               }
     ];
    
    [ZXDocClinicTool followDoctorWithAccout:[ZXAccountTool shareAccount] DID:@"1000000008"
                               successBlock:^(id responseObject) {
                                   NSDictionary *resonpseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                                   if ([resonpseDict[@"msg"] isEqualToString:@"add focus success"]) {
                                       //[MBProgressHUD showSuccess:@"修改成功"];
                                       NSLog(@"关注成功");
                                   } else if ([resonpseDict[@"msg"] isEqualToString:@"add talk fail"]) {
                                       NSLog(@"关注失败");
                                   }
                               }
                               failureBlock:^(NSError *error) {
                               }
     ];
     */
    
    
    // 添加成功返回Map<"msg", "del focus success">
    // 添加失败返回Map("msg", "del focus fail")
//    [ZXDocClinicTool cancelFollowDoctorWithAccout:[ZXAccountTool shareAccount]
//                                              DID:@"1000000008"
//                                     successBlock:^(id responseObject) {
//                                         NSDictionary *resonpseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//                                         if ([resonpseDict[@"msg"] isEqualToString:@"del focus success"]) {
//                                             //[MBProgressHUD showSuccess:@"修改成功"];
//                                             NSLog(@"取消关注成功");
//                                         } else if ([resonpseDict[@"msg"] isEqualToString:@"del focus fail"]) {
//                                             NSLog(@"取消关注失败");
//                                         }
//                                     }
//                                     failureBlock:^(NSError *error) {
//                                         NSLog(@"Cancel Follow Doctor ERR:%@",error);
//                                     }
//     ];
    
    
}


#pragma mark - init

- (NSMutableArray *)recommendedDoctors {
    if (!_recommendedDoctors) {
        _recommendedDoctors = [[NSMutableArray alloc] init];
    }
    return _recommendedDoctors;
}

- (NSMutableArray *)ads {
    if (!_ads) {
        _ads = [[NSMutableArray alloc] init];
    }
    return _ads;
}

/**
 *  联网请求广告数据
 */
- (void)fetchAdsData {
    [self.ads removeAllObjects];
    
    [ZXAdTool getAdsWithSuccessBlock:^(id responseObject) {
        NSDictionary *adInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        for (NSDictionary *adDict in adInfoJson) {
            @autoreleasepool {
                ZXAd *ad = [ZXAd yy_modelWithDictionary:adDict];
                [self.ads addObject:ad];
            }
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"fetchAdsData_ERR:%@",error);
    }];
}

/**
 *  联网请求医生数据（需要封装离线数据）
 */
- (void)fetchDocsData {
    //  判断是否有离线数据

    
    // 没有离线数据，联网请求
    
    //!!!!
    [self.recommendedDoctors removeAllObjects];
    
    [ZXGetDocsTool getDocsInfoWithParam:nil successBlock:^(id responseObject) {
        NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"getDocs_responseObject:%@",rStr);
    
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


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.recommendedDoctors.count < 5 ? self.recommendedDoctors.count : 5;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            ZXHomeMainCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kHomeMainCellID];
            cell.frame = CGRectMake(0, 0, Main_Screen_Width, kHomeMainCellHeight);
            
            [cell.questionBtn setImage:[UIImage imageNamed:@"question"] forState:UIControlStateNormal];
            [cell.questionBtn setTitle:NSLocalizedString(@"quickQuestions", nil) forState:UIControlStateNormal];
            [cell.questionBtn setTag:1];
            [cell.questionBtn addTarget:self action:@selector(mainCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.search4HosBtn setImage:[UIImage imageNamed:@"hospital"] forState:UIControlStateNormal];
            [cell.search4HosBtn setTitle:NSLocalizedString(@"search4Hos", nil) forState:UIControlStateNormal];
            [cell.search4HosBtn setTag:2];
            [cell.search4HosBtn addTarget:self action:@selector(mainCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.search4DocBtn setImage:[UIImage imageNamed:@"doctor"] forState:UIControlStateNormal];
            [cell.search4DocBtn setTitle:NSLocalizedString(@"search4Doc", nil) forState:UIControlStateNormal];
            [cell.search4DocBtn setTag:3];
            [cell.search4DocBtn addTarget:self action:@selector(mainCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.selfDigonseBtn setImage:[UIImage imageNamed:@"selfCheck"] forState:UIControlStateNormal];
            [cell.selfDigonseBtn setTitle:NSLocalizedString(@"selfDignose", nil) forState:UIControlStateNormal];
            [cell.selfDigonseBtn setTag:4];
            [cell.selfDigonseBtn addTarget:self action:@selector(mainCellBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }
            break;
        case 1: {
            ZXRDTableViewCell *cell = (ZXRDTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kRDCellIdentifier forIndexPath:indexPath];
            
            if (self.recommendedDoctors.count > 0) {
                ZXDoctor *doc = self.recommendedDoctors[indexPath.row];
                
                //粉丝数
                [ZXGetDocExtraInfo getDoctorFollowerNumberWithDID:doc.did successBlock:^(id responseObject) {
                    // NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    // NSLog(@"followerNum:%@",rStr);
                    NSDictionary *followerNum = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    // followerNum[@"num"] 类型为NSNumber 可以打印 不能赋值给NSString
                    doc.followerNum = [followerNum[@"num"] stringValue];
                } failureBlock:^(NSError *error) {
                    NSLog(@"getDoctorExtraInfo--followerNum ERR:%@",error);
                }];
                
                //服务人数
                [ZXGetDocExtraInfo getDoctorServeNumberWithDID:doc.did successBlock:^(id responseObject) {
                    // NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    // NSLog(@"serveNum:%@",rStr);
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
            break;
            
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kHomeMainCellHeight;
    }
    return kRDTableCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 130; // 广告条高度
            break;
        case 1:
            return kTitleCellHeight; // 标题高度
            break;
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: {
            CGRect frame = CGRectMake(0, 0, Main_Screen_Width, 130);
            ZXHomeAdView *view = [[ZXHomeAdView alloc] initWithFrame:frame andAds:_ads];
            view.delegate = self;
            return view;
        }
            break;
        case 1: {
            CGRect frame = CGRectMake(0, 0, Main_Screen_Width, kTitleCellHeight);
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 10, 0, 0);
            ZXInsetLabel *titleLabel = [[ZXInsetLabel alloc] initWithFrame:frame andInset:insets];
            titleLabel.text = NSLocalizedString(@"recommendedDoctors", nil);
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.font = [UIFont systemFontOfSize:15];
            titleLabel.textColor = [UIColor darkGrayColor];
            
            UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, kTitleCellHeight -1, Main_Screen_Width, 1)];
            seperator.backgroundColor = [UIColor blackColor];
            seperator.alpha = 0.25;
            
            [titleLabel addSubview:seperator];
            
            return titleLabel;
        }
            break;
        default:
            return nil;
            break;
    }
}


#pragma mark - TableView Delegate

- (void)mainCellBtnClick:(ZXVerticalButton *)btn {
    switch (btn.tag) {
        case 1: {
            // TODO:完成快速提问功能
            NSLog(@"快速提问");
        }
            break;
            
        case 2: {
            ZXSearch4HosTVC *tvc = [[ZXSearch4HosTVC alloc] init];
            [self.navigationController pushViewController:tvc animated:YES];
        }
            break;
            
        case 3: {

            ZXSearch4DocTVC *tvc = [[ZXSearch4DocTVC alloc] init];
            tvc.recommendedDoctors = [self.recommendedDoctors mutableCopy];
            [self.navigationController pushViewController:tvc animated:YES];
        }
            break;
            
        case 4: {
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        // 打开对应的医生的诊所
        ZXDoctor *doc = self.recommendedDoctors[indexPath.row];
        ZXDocClinicTVC *vc = [[ZXDocClinicTVC alloc] initClinicWithDoctor:doc];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - ZXHomeAdViewDelegate 

- (void)jumpAdPage:(NSString *)URL {
    if (System_Version >= 9.0) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:URL]  entersReaderIfAvailable:YES];
        [self presentViewController:safariViewController animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URL]];
    }
}

@end
