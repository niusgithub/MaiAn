//
//  ZXLoginVC.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/15.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZXLoginVCDidLoggedInDelegate <NSObject>

- (void)didLoggedIn;

@end

@interface ZXLoginVC : UIViewController
@property (nonatomic, weak) id<ZXLoginVCDidLoggedInDelegate> delegate;
@end
