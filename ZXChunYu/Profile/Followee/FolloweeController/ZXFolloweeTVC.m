//
//  ZXFolloweeTVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/24.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXFolloweeTVC.h"
#import "ZXDocClinicTVC.h"
#import "ZXRDTableViewCell.h"

#import "ZXGetDocsTool.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXDoctor.h"
#import "ZXGetDocExtraInfo.h"

#import "YYModel.h"
#import "MBProgressHUD+MJ.h"

@implementation ZXFolloweeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的医生";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.tableView registerNib:[UINib nibWithNibName:kRDTableCellNibName bundle:nil] forCellReuseIdentifier:kRDCellIdentifier];
    
    [self fetchDoctorData];
}

- (void)fetchDoctorData {
    [self.serverResponseObjects removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    [hud setLabelText:NSLocalizedString(@"loading", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [ZXGetDocsTool getUserFollowDoctorWithAccount:[ZXAccountTool shareAccount]
                                          startNumber:@0
                                         successBlock:^(id responseObject) {
                                             NSDictionary *docDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                                             
                                             for (NSDictionary *doc in docDict) {
                                                 @autoreleasepool {
                                                     ZXDoctor *doctor = [ZXDoctor yy_modelWithDictionary:doc];
                                                     [self.serverResponseObjects addObject:doctor];
                                                 }
                                             }
                                             
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [self.tableView reloadData];
                                                 [hud hide:YES];
                                             });
                                         }
                                         failureBlock:^(NSError *error) {
                                             NSLog(@"ZXFolloweeTVC ZXGetDocsTool ERR:%@", error);
                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                 [hud hide:YES];
                                                 [MBProgressHUD showError:@"医生数据请求失败!"];
                                             });
                                         }
         ];
    });
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXDoctor *doc = self.serverResponseObjects[indexPath.row];
    ZXDocClinicTVC *vc = [[ZXDocClinicTVC alloc] initClinicWithDoctor:doc];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.serverResponseObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRDTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXRDTableViewCell *cell = (ZXRDTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kRDCellIdentifier forIndexPath:indexPath];
    
    if (self.serverResponseObjects.count > 0) {
        ZXDoctor *doc = self.serverResponseObjects[indexPath.row];
        
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

@end
