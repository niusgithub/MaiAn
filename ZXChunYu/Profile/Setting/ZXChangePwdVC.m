//
//  ZXChangePwdVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/10.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXChangePwdVC.h"

#import "JVFloatLabeledTextField+ZX.h"

@interface ZXChangePwdVC ()
@property (weak, nonatomic) IBOutlet UILabel *changePwdL;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *oldPwdTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *changedPwdTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *comfirmPwdTF;
@end

@implementation ZXChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configureViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Configure View

- (void)configureViews {
    [self.changePwdL setText:NSLocalizedString(@"resetPassword", nil)];
    
    [_oldPwdTF defaultConfigurationWithPlaceHolder:@"oldPassword"];
    _oldPwdTF.secureTextEntry = YES;
    [_changedPwdTF defaultConfigurationWithPlaceHolder:@"newPassword"];
    _changedPwdTF.secureTextEntry = YES;
    [_comfirmPwdTF defaultConfigurationWithPlaceHolder:@"confirmPassword"];
    _comfirmPwdTF.secureTextEntry = YES;
}


#pragma mark - Button Click

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_oldPwdTF endEditing:YES];
    [_changedPwdTF endEditing:YES];
    [_comfirmPwdTF endEditing:YES];
}

- (IBAction)cancelBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)comfirmBtnClick {
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
