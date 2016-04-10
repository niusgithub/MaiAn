//
//  ZXRegistVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/23.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXRegistVC.h"
#import "ZXLoginVC.h"
#import "ZXCheckVerificationCodeVC.h"
#import "ZXFetchVerificationCodeTool.h"

#import "JVFloatLabeledTextField+ZX.h"
#import "MBProgressHUD+MJ.h"
#import <SMS_SDK/SMSSDK.h>

@interface ZXRegistVC ()
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneNumTF;
@end

@implementation ZXRegistVC

#pragma mark - View

- (void)viewDidLoad {
    
//    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    [_phoneNumTF defaultConfigurationWithPlaceHolder:@"phonecode"];
    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
    
//    _phoneNumTF.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    _phoneNumTF.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"phonecode", nil)
//                                    attributes:@{
//                                                 NSForegroundColorAttributeName : [UIColor darkGrayColor],
//                                                 NSParagraphStyleAttributeName : paragraphStyle
//                                                 }];
//    _phoneNumTF.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    _phoneNumTF.floatingLabelTextColor = [UIColor themeColor];
//    _phoneNumTF.floatingLabelActiveTextColor = [UIColor lightGrayColor];
//    _phoneNumTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _phoneNumTF.translatesAutoresizingMaskIntoConstraints = NO;
//    _phoneNumTF.keepBaseline = YES;
//    _phoneNumTF.keyboardType = UIKeyboardTypeNumberPad;
//    _phoneNumTF.keyboardAppearance = UIKeyboardAppearanceDark;
}


#pragma mark - Click

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.phoneNumTF endEditing:YES];
}

- (IBAction)cancelButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)toLoginVC {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getVerificationCode {
    
    [ZXFetchVerificationCodeTool hasPhoneCodeRegistered:_phoneNumTF.text successBlock:^(id responseObject) {
        NSDictionary *hasRegistered = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        // followerNum[@"num"] 类型为NSNumber 可以打印 不能赋值给NSString
        if ([hasRegistered[@"flag"] boolValue]) {
            [MBProgressHUD showError:@"该号码已经注册"];
        } else {
            [ZXFetchVerificationCodeTool fetchVerificationCodeByPhoneCode:_phoneNumTF.text successBlock:^{
                
                UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"ZXLoginStoryboard" bundle:nil];
                
                // vc id : checkVerifyCodeVC
                ZXCheckVerificationCodeVC *checkVC = [loginStoryboard instantiateViewControllerWithIdentifier:@"checkVerifyCodeVC"];
                // ZXCheckVerificationCodeVC *checkVC = [[ZXCheckVerificationCodeVC alloc] init]; // 无法加载VC
                checkVC.phoneCode =  _phoneNumTF.text;
                checkVC.type = ZXCheckVC4Regist;
                [self.navigationController pushViewController:checkVC animated:YES];
            }];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"getUserInfoData:%@",error);
        [MBProgressHUD showError:@"号码信息数据请求失败"];
    }];
}


@end
