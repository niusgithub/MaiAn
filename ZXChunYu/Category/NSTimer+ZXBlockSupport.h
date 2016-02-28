//
//  NSTimer+ZXBlockSupport.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/17.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ZXBlockSupport)

+ (NSTimer *)ZXScheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void(^)())block repeats:(BOOL)repeats;

@end
