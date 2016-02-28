//
//  NSTimer+ZXBlockSupport.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/17.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "NSTimer+ZXBlockSupport.h"

@implementation NSTimer (ZXBlockSupport)

+ (NSTimer *)ZXScheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats {
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(ZXBlockInvoke:) userInfo:[block copy] repeats:repeats];
}

+ (void)ZXBlockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
