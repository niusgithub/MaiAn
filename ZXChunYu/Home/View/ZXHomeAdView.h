//
//  ZXHomeAdView.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/8.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXHomeAdViewDelegate <NSObject>

- (void)jumpAdPage:(NSString *)URL;

@end


@interface ZXHomeAdView : UIView

@property (nonatomic, weak) id<ZXHomeAdViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame  andAds:(NSMutableArray *)ads;

@end
