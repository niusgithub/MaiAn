//
//  ZXUserEvaluation2Doc.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/3/26.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXUserEvaluation2Doc : NSObject

//uid,did,username,score,content

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *did;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *content;

@end
