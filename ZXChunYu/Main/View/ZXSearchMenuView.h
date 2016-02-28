//
//  ZXSearchMenuView.h
//  ZXChunYu
//
//  Created by yunmu on 16/1/11.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXSearchMenuViewDelegate <NSObject>

- (void)updateDataByArea:(NSString *)area;
- (void)updateDataByTitle:(NSString *)title;

@end

typedef NS_ENUM(NSInteger, ZXSearchMenuType) {
    ZXSearchMenuDoctor,
    ZXSearchMenuHospital
};

@interface ZXSearchMenuView : UIView

@property (nonatomic, assign) ZXSearchMenuType type;
@property (nonatomic, weak) id<ZXSearchMenuViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame andType:(ZXSearchMenuType)type;

@end
