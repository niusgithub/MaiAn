//
//  ZXDocClinicTVC+ZXRCChat.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/22.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXDocClinicTVC+ZXRCChat.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXMaiAnAPI.h"
#import "ZXDoctor.h"

@implementation ZXDocClinicTVC (ZXRCChat) 

- (void)chatWithDoctor:(NSString *)doctorRCID doctorName:(NSString *)doctorName {
    
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    //chat.targetId = @"2";
    chat.targetId = doctorRCID;
    //设置聊天会话界面要显示的标题
    chat.title = doctorName;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}

@end
