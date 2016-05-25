//
//  ZXQuickQuestionVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/25.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXQuickQuestionVC.h"
#import "UIBarButtonItem+ZX.h"
#import "ZXHomeTVCTool.h"
#import "MBProgressHUD+MJ.h"
#import "ZXCommon.h"

@interface ZXQuickQuestionVC () <UITextViewDelegate>
@property (nonatomic, strong) UITextView *questionTV;
@property (nonatomic, strong) UILabel *textLimitL;
@end

@implementation ZXQuickQuestionVC

- (void)viewDidLoad {
    
    self.title = @"快速提问";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UILabel *defaultTextL = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, Main_Screen_Width-10, 30)];
    defaultTextL.text = @"请描述您的症状或不适";
    defaultTextL.font = [UIFont systemFontOfSize:18];
    
    UITextView *questionTV = [[UITextView alloc] initWithFrame:CGRectMake(5, 40, Main_Screen_Width-10, Main_Screen_Height/3)];
    questionTV.delegate = self;
    questionTV.font = [UIFont systemFontOfSize:16];
    questionTV.layer.borderWidth = 1.0;
    questionTV.layer.cornerRadius = 5.0;
    questionTV.layer.borderColor = [[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor];
    self.questionTV = questionTV;
    
    UILabel *textLimitL = [[UILabel alloc] initWithFrame:CGRectMake(10, 45 + Main_Screen_Height/3, Main_Screen_Width-20, 30)];
    textLimitL.text = @"0/100";
    textLimitL.font = [UIFont systemFontOfSize:18];
    textLimitL.textAlignment = NSTextAlignmentRight;
    self.textLimitL = textLimitL;

    [self.view addSubview:defaultTextL];
    [self.view addSubview:questionTV];
    [self.view addSubview:textLimitL];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"sendMessage" highImageName:@"sendMessage" target:self action:@selector(sendQuestion)];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.questionTV becomeFirstResponder];
}


#pragma mark - UITextView Delegate

- (void)textViewDidChange:(UITextView *)textView {
    NSLog(@"textViewDidChange");
    self.textLimitL.text = [NSString stringWithFormat:@"%ld/100", (unsigned long)_questionTV.text.length];
}


#pragma mark -

- (void)sendQuestion {
    
    long qLength = _questionTV.text.length;
    
    if ( qLength> 0 && qLength <=100) {
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [ZXHomeTVCTool quickFreeQA:_questionTV.text
                          successBlock:^(id responseObject) {
                              NSString *responseStatus = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                              if ([responseStatus isEqualToString:@"\"SUCCESS\""]) {
                                  [MBProgressHUD showSuccess:@"提问已发送"];
                                  [self.navigationController popViewControllerAnimated:YES];
                              } else {
                                  [MBProgressHUD showError:@"提问发送失败"];
                              }
                          }
                          failureBlock:^(NSError *error) {
                              NSLog(@"ZXHomeTVCTool quickFreeQA ERR:%@", error);
                          }
             ];
        //});
    } else if (qLength > 100) {
        [MBProgressHUD showError:@"提问长度超出限制"];
    } else {
        [MBProgressHUD showError:@"提问内容为空"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.questionTV endEditing:YES];
}

@end
