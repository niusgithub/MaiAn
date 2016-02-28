//
//  ZXLabelButtonVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/24.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXConfirmPasswordVC.h"

#import "ZXLoginTool.h"

#import "JVFloatLabeledTextField.h"

#import "ZXCommon.h"
#import "UIColor+ZX.h"

#import "MBProgressHUD+MJ.h"

@interface ZXConfirmPasswordVC ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *passwordTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *confirmPasswordTF;

@end


@implementation ZXConfirmPasswordVC

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.type) {
        case ZXConfirmPasswordVCReigst:
            self.titleL.text = @"输入密码";
            break;
            
        case ZXConfirmPasswordVCReset:
            self.titleL.text = @"重置密码";
            break;
    }
    
    UIColor *activeTextColor = [UIColor lightGrayColor];
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    _passwordTF.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _passwordTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"输入密码"
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
    _passwordTF.keyboardAppearance = UIKeyboardAppearanceDefault;
    
    _confirmPasswordTF.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    _confirmPasswordTF.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:@"确认密码"
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                                 NSParagraphStyleAttributeName : paragraphStyle
                                                 }];
    _confirmPasswordTF.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    _confirmPasswordTF.floatingLabelTextColor = [UIColor themeColor];
    _confirmPasswordTF.floatingLabelActiveTextColor = activeTextColor;
    _confirmPasswordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    _confirmPasswordTF.translatesAutoresizingMaskIntoConstraints = NO;
    _confirmPasswordTF.keepBaseline = YES;
    _confirmPasswordTF.secureTextEntry = YES;
    _confirmPasswordTF.keyboardAppearance = UIKeyboardAppearanceDefault;
}


#pragma mark - Button Click

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)confirmButtonClick {
    [self.view endEditing:YES];
    if ([_passwordTF.text isEqualToString:_confirmPasswordTF.text]) {
        self.buttonClick();
        
        switch (self.type) {
            case ZXConfirmPasswordVCReigst: {
                [ZXLoginTool userRegistWithUsername:_phoneCode password:_passwordTF.text successBlock:^(id responseObject) {
                    // 注册成功返回 Map<"msg", "register success">
                    // 注册失败返回 Map<"msg", "register fail">
                    NSDictionary *responseString = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    NSString *msg = responseString[@"msg"];
                    if ([msg isEqualToString:@"register success"]) {
                        [MBProgressHUD showSuccess:@"密码设置成功"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    } else {//if ([msg isEqualToString:(nonnull NSString *)])
                        [MBProgressHUD showError:@"服务器错误，密码设置失败"];
                    }
                    
                } failureBlock:^(NSError *error) {
                    NSLog(@"设置密码失败:%@", error);
                    [MBProgressHUD showError:@"密码设置失败"];
                }];
            }
                break;
                
            case ZXConfirmPasswordVCReset: {
                [ZXLoginTool updateUserPasswordWithUsername:_phoneCode newPassword:_passwordTF.text successBlock:^(id responseObject) {
                    // 添加成功返回 Map<"msg", "update success">
                    // 添加失败返回 Map<"msg", "update fail">
                    NSDictionary *responseString = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    NSString *msg = responseString[@"msg"];
                    if ([msg isEqualToString:@"update success"]) {
                        [MBProgressHUD showSuccess:@"密码设置成功"];
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    } else {//if ([msg isEqualToString:(nonnull NSString *)])
                        [MBProgressHUD showError:@"服务器错误，密码设置失败"];
                    }
                    
                } failureBlock:^(NSError *error) {
                    NSLog(@"设置密码失败:%@", error);
                    [MBProgressHUD showError:@"密码设置失败"];
                }];
            }
                break;
        }
    } else {
        [MBProgressHUD showError:@"两次输入的密码不一致"];
    }
}

- (IBAction)backBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
