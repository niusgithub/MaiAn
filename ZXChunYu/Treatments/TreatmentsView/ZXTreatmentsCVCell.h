//
//  ZXTreatmentsCVCell.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/17.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXTreatments;

extern NSString *const kTreatmentsCellIdentifier;
extern NSString *const kTreatmentsCellNibName;

@interface ZXTreatmentsCVCell : UICollectionViewCell

- (void)configureWithTreatments:(ZXTreatments *)treatments;

@end
