//
//  JVFloatLabeledTextField+ZX.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/10.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "JVFloatLabeledTextField+ZX.h"

#import "ZXCommon.h"
#import "UIColor+ZX.h"

@implementation JVFloatLabeledTextField (ZX)

- (void)defaultConfigurationWithPlaceHolder:(NSString *)placeHolder {
    UIColor *activeTextColor = [UIColor lightGrayColor];
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    self.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    self.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(placeHolder, nil)
                                    attributes:@{
                                                 NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                                 NSParagraphStyleAttributeName : paragraphStyle
                                                 }];
    self.floatingLabelFont = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    self.floatingLabelTextColor = [UIColor themeColor];
    self.floatingLabelActiveTextColor = activeTextColor;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.keepBaseline = YES;
    self.keyboardAppearance = UIKeyboardAppearanceAlert;
}

@end
