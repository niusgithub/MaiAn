//
//  ZXUserInfoTVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXUserInfoTVC.h"
#import "ZXUserInfoTool.h"
#import "ZXUserInfo.h"
#import "ZXEditUserInfoVc.h"

#import "ZXCommon.h"

#import "ZXAccount.h"
#import "ZXAccountTool.h"

#import "UIImage+ZX.h"
#import "UIColor+ZX.h"

#import "YYModel.h"
#import "MBProgressHUD+MJ.h"
#import <RongIMKit/RongIMKit.h>

static NSString *reuseCellId = @"userInfoCellId";

@interface ZXUserInfoTVC ()
@property (nonatomic, strong) ZXUserInfo *userInfo;
@end

@implementation ZXUserInfoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // 设置背景色
    UIView *view = [[UIView alloc] initWithFrame:self.tableView.frame];
    [view setBackgroundColor:[UIColor themeBGColor]];
    [self.tableView setBackgroundView:view];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] init];
    btn.title = @"返回";
    self.navigationItem.backBarButtonItem = btn;
    
    UIBarButtonItem *editInfoButton = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toEditUserInfoView)];
    self.navigationItem.rightBarButtonItem = editInfoButton;
    
    [self getUserInfoData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Click

- (void)toEditUserInfoView {
    ZXEditUserInfoVc *vc = [[ZXEditUserInfoVc alloc] init];
    vc.userInfo = _userInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)getUserInfoData {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [ZXUserInfoTool getUserInfoWithAccount:[ZXAccountTool shareAccount] successBlock:^(id responseObject) {
//            NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSLog(@"getUserInfoData:%@",rStr);
            NSDictionary *userInfoDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            _userInfo = [ZXUserInfo yy_modelWithDictionary:userInfoDict];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                [hud hide:YES];
            });
        } failureBlock:^(NSError *error) {
            NSLog(@"getUserInfoData:%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [MBProgressHUD showError:@"个人信息数据请求失败!"];
            });
        }];
    });
}

#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseCellId];
        
        //        "UNMARRIED" = "未婚";
        //        "MARRIED" = "已婚";
        //        "MAN" = "男";
        //        "WOMAN" = "女";
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"昵称";
                cell.detailTextLabel.text = _userInfo.nickname;
                break;
            case 1:
                cell.textLabel.text = @"年龄";
                cell.detailTextLabel.text = _userInfo.age;
                break;
            case 2:
                cell.textLabel.text = @"性别";
                cell.detailTextLabel.text = NSLocalizedString(_userInfo.gender, nil);
                break;
            case 3:
                cell.textLabel.text = @"婚姻状况";
                cell.detailTextLabel.text = NSLocalizedString(_userInfo.marital_status, nil);
                break;
            case 4:
                cell.textLabel.text = @"身高";
                cell.detailTextLabel.text = _userInfo.height;
                break;
            case 5:
                cell.textLabel.text = @"体重";
                cell.detailTextLabel.text = _userInfo.weight;
                break;
            case 6:
                cell.textLabel.text = @"身份证号";
                cell.detailTextLabel.text = _userInfo.sfz_num;
                break;
        }
        return cell;
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        
        UIButton *exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 44)];
        [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [exitBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [exitBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        //[exitBtn setBackgroundColor:ZXBGLightGray];
        
        [cell.contentView addSubview:exitBtn];
        
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 7;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 50;
    }
    return 0;
}

- (void)logout {
    if ([ZXAccountTool removeAccount]) {
        // 登出融云
        [[RCIM sharedRCIM] logout];
        
        if ([self.delegate respondsToSelector:@selector(toLogoutStatus)]) {
            [MBProgressHUD showSuccess:@"退出登录"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self.delegate toLogoutStatus];
        }
    }
}


@end
