//
//  ZXButtomCell.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/22.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXButtomCell.h"

@interface ZXButtomCell ()

@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@end


@implementation ZXButtomCell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor themeColor];
        
        _type = ZXButtomCellTypeInvisible;
        
        [self setLayout];
    }
    return self;
}

- (void)setLayout {
    //_textLabel.textColor = [UIColor titleColor];
    _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
    //_textLabel.backgroundColor = [UIColor themeColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = [UIFont boldSystemFontOfSize:14];
    [self addSubview:_textLabel];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.autoresizingMask = UIViewAutoresizingFlexibleTopMargin  | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _indicator.color = [UIColor colorWithRed:54/255 green:54/255 blue:54/255 alpha:1.0];
    _indicator.center = self.center;
    [self addSubview:_indicator];
}


- (BOOL)shouldResponseToTouch {
    return _type == ZXButtomCellTypeMore || _type == ZXButtomCellTypeError;
}

- (void)setType:(ZXButtomCellType)type {
    if (type == ZXButtomCellTypeLoading) {
        [_indicator startAnimating];
        _indicator.hidden = NO;
    } else {
        [_indicator stopAnimating];
        _indicator.hidden = YES;
    }
    
    // @[] NSArray    array[index]
    _textLabel.text = @[
                        @"",
                        @"点击加载更多",
                        @"",
                        @"加载数据出错",
                        @"全部加载完毕",
                        _emptyMessage ?: @"",
                        ][type];
    
    _type = type;
}


@end
