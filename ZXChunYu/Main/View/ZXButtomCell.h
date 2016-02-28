//
//  ZXButtomCell.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/22.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZXButtomCellType) {
    ZXButtomCellTypeInvisible,
    ZXButtomCellTypeMore,
    ZXButtomCellTypeLoading,
    ZXButtomCellTypeError,
    ZXButtomCellTypeFinished,
    ZXButtomCellTypeEmpty,
};


@interface ZXButtomCell : UIView

@property (nonatomic, assign) ZXButtomCellType type;
@property (nonatomic, assign, readonly) BOOL shouldResponseToTouch;
@property (nonatomic, copy) NSString *emptyMessage;

@property (nonatomic, strong) UILabel *textLabel;

@end
