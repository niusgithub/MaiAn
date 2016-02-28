//
//  ZXHospital.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHospital : NSObject

@property (nonatomic, copy) NSString *hid;
@property (nonatomic, copy) NSString *hs_name;
@property (nonatomic, copy) NSString *hs_area;
@property (nonatomic, copy) NSString *hs_title;
@property (nonatomic, copy) NSString *hs_desc;
@property (nonatomic, copy) NSString *hs_icon_path;
//医院标签
@property (nonatomic, strong) NSArray *hs_marks;
@property (nonatomic, strong) NSArray *hs_docs;
@property (nonatomic, copy) NSString *hs_phone;
@property (nonatomic, copy) NSString *hs_coordinate;
@property (nonatomic, strong) NSArray *imagePaths;

@end
