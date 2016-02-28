//
//  ZXEditUserInfoVc.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXEditUserInfoVc.h"
#import "ZXUserInfo.h"
#import "ZXUserInfoTool.h"

#import "ZXAccountTool.h"
#import "ZXAccount.h"

#import "MBProgressHUD+MJ.h"

@interface ZXEditUserInfoVc ()

@property (weak, nonatomic) IBOutlet UITextField *nicknameL;
@property (weak, nonatomic) IBOutlet UITextField *ageL;
@property (weak, nonatomic) IBOutlet UITextField *heightL;
@property (weak, nonatomic) IBOutlet UITextField *weightL;
@property (weak, nonatomic) IBOutlet UITextField *IDCodeL;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSC;
@property (weak, nonatomic) IBOutlet UISegmentedControl *maritalStatusSC;

@end

@implementation ZXEditUserInfoVc

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"修改个人信息";
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)]];
    
    _nicknameL.text = _userInfo.nickname;
    _ageL.text = _userInfo.age;
    _heightL.text = _userInfo.height;
    _weightL.text = _userInfo.weight;
    _IDCodeL.text = _userInfo.sfz_num;
    if ([_userInfo.gender isEqualToString:@"MAN"]) {
        _sexSC.selectedSegmentIndex = 0;
    } else {
        _sexSC.selectedSegmentIndex = 1;
    }
    if ([_userInfo.marital_status isEqualToString:@"UNMARRIED"]) {
        _sexSC.selectedSegmentIndex = 0;
    } else {
        _sexSC.selectedSegmentIndex = 1;
    }
}

- (void)singleTap {
    [self.view endEditing:YES];
}

- (IBAction)confirmUserInfo {
    
//FIXME:没有检查数据的格式 会出现500
    ZXUserInfo *newUserInfo = [[ZXUserInfo alloc] init];
    
    newUserInfo.user = [ZXAccountTool shareAccount];
    newUserInfo.uid = [ZXAccountTool shareAccount].uid;
    
    newUserInfo.nickname = self.nicknameL.text;
    newUserInfo.age = self.ageL.text;
    newUserInfo.height = self.heightL.text;
    newUserInfo.weight = self.weightL.text;
    newUserInfo.sfz_num = self.IDCodeL.text;
    
    if (self.sexSC.selectedSegmentIndex == 0) {
        newUserInfo.gender = @"MAN";
    } else {
        newUserInfo.gender = @"WOMAN";
    }
    
    if (self.maritalStatusSC.selectedSegmentIndex == 0) {
        newUserInfo.marital_status = @"UNMARRIED";
    } else {
        newUserInfo.marital_status = @"MARRIED";
    }
    
    // 更改成功返回 Map<"msg", "update success">
    // 更改失败返回 Map<"msg", "update fail">
    [ZXUserInfoTool updateUserInfoWithUserInfo:newUserInfo successBlock:^(id responseObject) {
        NSDictionary *resonpseDict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        if ([resonpseDict[@"msg"] isEqualToString:@"update success"]) {
            [MBProgressHUD showSuccess:@"修改成功"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else if ([resonpseDict[@"msg"] isEqualToString:@"update fail"]) {
            [MBProgressHUD showError:@"修改失败"];
        }
    } failureBlock:^(NSError *error) {
        if (error) {
            [MBProgressHUD showError:@"修改失败,请输入正确的数据格式"];
        }
        NSLog(@"updateUserInfoWithUserInfo-%@", error);
    }];
}

@end
