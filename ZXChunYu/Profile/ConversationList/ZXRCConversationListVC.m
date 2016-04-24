//
//  ZXRCConversationListVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/22.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXRCConversationListVC.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXMaiAnAPI.h"

@implementation ZXRCConversationListVC

- (void)viewDidLoad {
    //重写显示相关的接口，必须先调用super，否则会屏蔽SDK默认的处理
    [super viewDidLoad];
    
    self.title = @"我的提问";
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabBarController.tabBar.hidden = YES;
    
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    
    //设置需要将哪些类型的会话在会话列表中聚合显示
    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
                                          @(ConversationType_GROUP)]];
    
}

//重写RCConversationListViewController的onSelectedTableRow事件
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType
         conversationModel:(RCConversationModel *)model
               atIndexPath:(NSIndexPath *)indexPath {
    
    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    conversationVC.conversationType = model.conversationType;
    conversationVC.targetId = model.targetId;
    conversationVC.title = model.conversationTitle;
    
    [self.navigationController pushViewController:conversationVC animated:YES];
}

@end
