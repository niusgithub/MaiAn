//
//  ZXPhoneNum4ResetVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/25.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXPhoneNum4ResetVC.h"
#import "ZXCheckVerificationCodeVC.h"
#import "ZXFetchVerificationCodeTool.h"

#import "JVFloatLabeledTextField+ZX.h"
#import "MBProgressHUD+MJ.h"

@interface ZXPhoneNum4ResetVC ()
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *phoneCodeTF;
@end

@implementation ZXPhoneNum4ResetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_phoneCodeTF defaultConfigurationWithPlaceHolder:@"phonecode"];
    _phoneCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    
//    UIColor *activeTextColor = [UIColor lightGrayColor];
//    
//    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    
//    _phoneCodeTF.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    _phoneCodeTF.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"phonecode", nil)
//                                    attributes:@{
//                                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
//                                                 NSParagraphStyleAttributeName : paragraphStyle
//                                                 }];
//    _phoneCodeTF.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    _phoneCodeTF.floatingLabelTextColor = [UIColor themeColor];
//    _phoneCodeTF.floatingLabelActiveTextColor = activeTextColor;
//    _phoneCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _phoneCodeTF.translatesAutoresizingMaskIntoConstraints = NO;
//    _phoneCodeTF.keepBaseline = YES;
//    _phoneCodeTF.keyboardType = UIKeyboardTypeNumberPad;
//    _phoneCodeTF.keyboardAppearance = UIKeyboardAppearanceAlert;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Button Click

- (IBAction)fetchVerifyCode4Reset {
    __weak __typeof(self) weakSelf = self;
    
    [ZXFetchVerificationCodeTool hasPhoneCodeRegistered:_phoneCodeTF.text successBlock:^(id responseObject) {
        
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        NSDictionary *hasRegistered = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        // followerNum[@"num"] 类型为NSNumber 可以打印 不能赋值给NSString
        if ([hasRegistered[@"flag"] boolValue]) {
            NSLog(@"已经注册");
            [ZXFetchVerificationCodeTool fetchVerificationCodeByPhoneCode:strongSelf.phoneCodeTF.text successBlock:^{
                
                UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"ZXLoginStoryboard" bundle:nil];
                
                // vc id : checkVerifyCodeVC
                ZXCheckVerificationCodeVC *checkVC = [loginStoryboard instantiateViewControllerWithIdentifier:@"checkVerifyCodeVC"];
                checkVC.phoneCode = strongSelf.phoneCodeTF.text;
                checkVC.type = ZXCheckVC4ResetPassword;
                [self.navigationController pushViewController:checkVC animated:YES];
            }];
        } else {
            [MBProgressHUD showError:@"号码格式错误或尚未注册"];
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"getUserInfoData:%@",error);
        [MBProgressHUD showError:@"号码信息数据请求失败"];
    }];
}

- (IBAction)cancelBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
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
