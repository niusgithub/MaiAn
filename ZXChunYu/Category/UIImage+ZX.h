//
//  UIImage+ZX.h
//  XAlbum
//
//  Created by 陈知行 on 15/7/9.
//  Copyright (c) 2015年 yunmu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZX)

+ (UIImage *)resizedImage:(NSString *)name;

- (UIImage *)largestCenteredSquareImage;
- (UIImage *)resizeToTargetSize:(CGSize)targetSize;

@end
