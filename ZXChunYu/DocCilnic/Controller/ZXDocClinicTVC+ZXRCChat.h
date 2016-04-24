//
//  ZXDocClinicTVC+ZXRCChat.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/22.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXDocClinicTVC.h"
#import <RongIMKit/RongIMKit.h>

@interface ZXDocClinicTVC (ZXRCChat)

- (void)chatWithDoctor:(NSString *)doctorRCID doctorName:(NSString *)doctorName;

@end
