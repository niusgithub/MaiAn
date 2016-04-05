//
//  ZXLoginVC.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXLoginVC.h"

#import "ZXCommon.h"
#import "UIColor+ZX.h"
#import "ZXLoginParams.h"
#import "ZXLoginTool.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXGetDocsTool.h"

#import "ZXRegistVC.h"

#import "YYModel.h"
#import "JVFloatLabeledTextField.h"
#import "MBProgressHUD+MJ.h"
#import <RongIMKit/RongIMKit.h>

@interface ZXLoginVC ()

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *accountTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ZXLoginVC

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap)]];
    
    UIColor *activeTextColor = [UIColor lightGrayColor];
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    _accountTF.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _accountTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"phonecode", nil)
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                                 NSParagraphStyleAttributeName : paragraphStyle
                                                 }];
    _accountTF.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _accountTF.floatingLabelTextColor = [UIColor themeColor];
    _accountTF.floatingLabelActiveTextColor = activeTextColor;
    _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _accountTF.translatesAutoresizingMaskIntoConstraints = NO;
    _accountTF.keepBaseline = YES;
    _accountTF.keyboardType = UIKeyboardTypeNumberPad;
    _accountTF.keyboardAppearance = UIKeyboardAppearanceAlert;
    
    _passwordTF.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _passwordTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"password", nil)
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                                 NSParagraphStyleAttributeName : paragraphStyle
                                                 }];
    _passwordTF.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _passwordTF.floatingLabelTextColor = [UIColor themeColor];
    _passwordTF.floatingLabelActiveTextColor = activeTextColor;
    _passwordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTF.translatesAutoresizingMaskIntoConstraints = NO;
    _passwordTF.keepBaseline = YES;
    _passwordTF.secureTextEntry = YES;
    _passwordTF.keyboardAppearance = UIKeyboardAppearanceAlert;
}


#pragma mark - Button Click

- (void)singleTap {
    [self.accountTF endEditing:YES];
    [self.passwordTF endEditing:YES];
}

//FIXME:没检查textField的内容
- (IBAction)Login:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    self.username = self.accountTF.text;
    self.password = self.passwordTF.text;
    
    ZXLoginParams *loginParams = [[ZXLoginParams alloc] init];
    loginParams.username = self.accountTF.text;
    loginParams.passwd = self.passwordTF.text;
    
    [ZXLoginTool getLoginInfoWithParam:[loginParams yy_modelToJSONObject] successBlock:^(id responseObject) {
//        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"ZXLoginVC:%@",responseStr);
        ZXAccount *account = [ZXAccount yy_modelWithJSON:responseObject];
        if ([account.uid isEqualToString:@"-1"]) {
            XZXLog(@"账号/密码错误");
            [MBProgressHUD showError:@"账号/密码错误"];
        } else {
            // 登录成功，保存账号信息并更新个人中心的账户cell，然后退出当前界面
            // 获取关注的医生的ID并保存在accout中
            [ZXGetDocsTool getUserFollowDoctorWithAccount:account
                                              startNumber:@0
                                             successBlock:^(id doctorObject) {
//                NSString *rStr = [[NSString alloc] initWithData:doctorObject encoding:NSUTF8StringEncoding];
//                NSLog(@"ZXLoginVC Doctor:%@", rStr);
                
                NSDictionary *docInfoDict = [NSJSONSerialization JSONObjectWithData:doctorObject options:0 error:nil];
                
                [account.mDocIDs removeAllObjects];
                
                for (NSDictionary *docDict in docInfoDict) {
                    @autoreleasepool {
                        NSString *docID = docDict[@"did"];
                        [account.mDocIDs addObject:docID];
                    }
                }
                                                 
                [ZXAccountTool saveAccount:account];
            } failureBlock:^(NSError *error) {
                XZXLog(@"ZXLoginVC Doctor ERR:%@",error);
            }];
            
            // 登录融云
            [[RCIM sharedRCIM] connectWithToken:account.token success:^(NSString *userId) {
                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
            } error:^(RCConnectErrorCode status) {
                NSLog(@"登陆的错误码为:%ld", (long)status);
            } tokenIncorrect:^{
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                NSLog(@"token错误");
            }];
            
            if ([self.delegate respondsToSelector:@selector(didLoggedIn)]) {
                [self.delegate didLoggedIn];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failureBlock:^(NSError *err) {
        XZXLog(@"ZXLoginVC ERR:%@",err);
    }];
}

- (IBAction)cancelButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)ResetPassword {
//    ZXLabelButtonVC *vc = [[ZXLabelButtonVC alloc] init];
//    vc.labelText = @"重置密码";
//    vc.placeholderText = @"手机号";
//    vc.buttonText = @"获取验证码";
//    vc.buttonOnClick = ^(NSString *str){
//        NSLog(@"手机号:%@",str);
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}




@end
