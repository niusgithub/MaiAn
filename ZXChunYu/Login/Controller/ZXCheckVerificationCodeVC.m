//
//  ZXCheckVerificationCodeVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/1/25.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXCheckVerificationCodeVC.h"
#import "ZXConfirmPasswordVC.h"
#import "ZXFetchVerificationCodeTool.h"

#import "JVFloatLabeledTextField+ZX.h"

@interface ZXCheckVerificationCodeVC ()

@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;

@end

@implementation ZXCheckVerificationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_verificationCodeTF defaultConfigurationWithPlaceHolder:@"Code"];
    _verificationCodeTF.keyboardType = UIKeyboardTypeNumberPad;
    
//    UIColor *activeTextColor = [UIColor lightGrayColor];
//    
//    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    
//    _verificationCodeTF.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//    _verificationCodeTF.attributedPlaceholder =
//    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Code", nil)
//                                    attributes:@{
//                                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
//                                                 NSParagraphStyleAttributeName : paragraphStyle
//                                                 }];
//    _verificationCodeTF.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//    _verificationCodeTF.floatingLabelTextColor = [UIColor themeColor];
//    _verificationCodeTF.floatingLabelActiveTextColor = activeTextColor;
//    _verificationCodeTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//    _verificationCodeTF.translatesAutoresizingMaskIntoConstraints = NO;
//    _verificationCodeTF.keepBaseline = YES;
//    _verificationCodeTF.keyboardType = UIKeyboardTypeNumberPad;
//    _verificationCodeTF.keyboardAppearance = UIKeyboardAppearanceAlert;
}

#pragma mark -

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)cancelBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextStepBtnClick {
    if(_verificationCodeTF.text.length != 4) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notice", nil)
                                                        message:NSLocalizedString(@"verifycodeformaterror", nil)
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    } else {
        __weak __typeof(self) weakSelf = self;
        
        [ZXFetchVerificationCodeTool comfirmVerificationCodeWithVerifyCode:_verificationCodeTF.text phoneCode:_phoneCode successBlock:^{
            
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ZXLoginStoryboard" bundle:nil];
            
            ZXConfirmPasswordVC *vc = [sb instantiateViewControllerWithIdentifier:@"confirmPasswordVC"];
            vc.phoneCode = strongSelf.phoneCode;
            
            if (self.type == ZXCheckVC4Regist) {
                vc.type = ZXConfirmPasswordVCReigst;
                vc.buttonClick = ^(){
                    NSLog(@"输入密码");
                };
                
            } else if (self.type == ZXCheckVC4ResetPassword) {
                vc.type = ZXConfirmPasswordVCReset;
                vc.labelText = @"重置密码";
                vc.buttonClick = ^(){
                    NSLog(@"重置密码");
                };
            }
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }

}

@end
