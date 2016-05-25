//
//  ZXRCIMManager.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/29.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXRCIMManager.h"

@implementation ZXRCIMManager

static id sharedInstance;

+ (instancetype)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        [RCIM sharedRCIM].receiveMessageDelegate = self;
        self.messageCount = 0;
    }
    return self;
}


#pragma mark - RCIMReceiveMessage Delegate

- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    NSLog(@"onRCIMReceiveMessage");
    self.messageCount++;
    
    if ([self.msgDelegate respondsToSelector:@selector(receiveNewMsg)]) {
        [self.msgDelegate receiveNewMsg];
    }
}

@end
