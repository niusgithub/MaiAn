//
//  ZXFreeQuestion.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/4/25.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZXQ_Status) {
    NCHOSED,
    PROCESSING,
    NEVALUATED,
    CLOSED
};

@interface ZXFreeQuestion : NSObject

@property (nonatomic, copy) NSString *qid;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *did;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) ZXQ_Status status;
@property (nonatomic, copy) NSString *commitTime;

@end
