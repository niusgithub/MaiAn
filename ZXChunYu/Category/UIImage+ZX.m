//
//  UIImage+ZX.m
//  XAlbum
//
//  Created by 陈知行 on 15/7/9.
//  Copyright (c) 2015年 yunmu. All rights reserved.
//

#import "UIImage+ZX.h"
#import <UIKit/UIKit.h>

@implementation UIImage (ZX)

+ (UIImage *)resizedImage:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

/*
 func largestCenteredSquareImage() -> UIImage {
 let scale = self.scale
 
 let originalWidth  = self.size.width * scale
 let originalHeight = self.size.height * scale
 
 let edge: CGFloat
 if originalWidth > originalHeight {
 edge = originalHeight
 } else {
 edge = originalWidth
 }
 
 let posX = (originalWidth  - edge) / 2.0
 let posY = (originalHeight - edge) / 2.0
 
 let cropSquare = CGRectMake(posX, posY, edge, edge)
 
 let imageRef = CGImageCreateWithImageInRect(self.CGImage, cropSquare)!
 
 return UIImage(CGImage: imageRef, scale: scale, orientation: self.imageOrientation)
 }
 */

- (UIImage *)largestCenteredSquareImage {
    CGFloat scale = self.scale;
    
    CGFloat originalWidth = self.size.width * scale;
    CGFloat originalHeight = self.size.height * scale;
    
    CGFloat edge;
    
    if (originalWidth > originalHeight) {
        edge = originalHeight;
    } else {
        edge = originalWidth;
    }
    
    CGFloat posX = (originalWidth - edge) / 2.0;
    CGFloat posY = (originalHeight - edge) / 2.0;
    
    CGRect cropSquare = CGRectMake(posX, posY, edge, edge);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, cropSquare);
    
    return [UIImage imageWithCGImage:imageRef scale:scale orientation:self.imageOrientation];
}

- (UIImage *)resizeToTargetSize:(CGSize)targetSize {
    CGSize size = self.size;
    
    CGFloat widthRatio = targetSize.width / size.width;
    CGFloat heightRatio = targetSize.height / size.height;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGSize newSize;
    
    if (widthRatio > heightRatio) {
        newSize = CGSizeMake(scale * floor(size.width * heightRatio), scale * floor(size.height * heightRatio));
    } else {
        newSize = CGSizeMake(scale * floor(size.width * widthRatio), scale * floor(size.height * widthRatio));
    }
    
    CGRect rect = CGRectMake(0, 0, floor(newSize.width), floor(newSize.height));
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0);
    [self drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
