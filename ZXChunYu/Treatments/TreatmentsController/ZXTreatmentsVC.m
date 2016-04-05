//
//  ZXTreatmentsVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/17.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXTreatmentsVC.h"
#import "ZXTreatmentsCVCell.h"
#import "ZXTreatments.h"
#import "ZXTreatmentsTool.h"

#import "ZXCommon.h"
#import "ZXMaiAnAPI.h"
#import "UIColor+ZX.h"

#import "YYModel.h"
#import "MBProgressHUD+MJ.h"
#import <SafariServices/SafariServices.h>

@interface ZXTreatmentsVC () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *treatmentsCV;
@property (nonatomic, strong) NSMutableArray *treatments;

@end

@implementation ZXTreatmentsVC

- (NSMutableArray *)treatments {
    if (!_treatments) {
        _treatments = [[NSMutableArray alloc] init];
    }
    return _treatments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"健康产品";
    
    _treatmentsCV.delegate = self;
    _treatmentsCV.dataSource = self;
    _treatmentsCV.showsVerticalScrollIndicator = NO;
    _treatmentsCV.backgroundColor = [UIColor themeBGColor];
    
    [_treatmentsCV registerNib:[UINib nibWithNibName:kTreatmentsCellNibName bundle:nil] forCellWithReuseIdentifier:kTreatmentsCellIdentifier];
    
    [self fetchTreatmentsData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchTreatmentsData {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [ZXTreatmentsTool getGoodsByStartNumber:@0 successBlock:^(id responseObject) {
//            NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSLog(@"getGoods_responseObject:%@",rStr);
            
            NSDictionary *goodsJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            for (NSDictionary *goodsDict in goodsJson) {
                @autoreleasepool {
                    ZXTreatments *goods = [ZXTreatments yy_modelWithDictionary:goodsDict];
                    [self.treatments addObject:goods];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.treatmentsCV reloadData];
                [hud hide:YES];
            });
        } failureBlock:^(NSError *error) {
            NSLog(@"getGoods ERROR:%@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [MBProgressHUD showError:@"健康产品数据请求失败!"];
            });
        }];
    });
}


#pragma mark - UICollectionView DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.treatments.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXTreatmentsCVCell *cell = (ZXTreatmentsCVCell *)[self.treatmentsCV dequeueReusableCellWithReuseIdentifier:kTreatmentsCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXTreatments *goods = self.treatments[indexPath.row];
    [(ZXTreatmentsCVCell *)cell configureWithTreatments:goods];
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZXTreatments *goods = self.treatments[indexPath.row];
    
    if (System_Version >= 9.0) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[ZXMaiAn_RESOURCE_PREFIX stringByAppendingString:goods.gs_dtl_path]] entersReaderIfAvailable:YES];
        [self presentViewController:safariViewController animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ZXMaiAn_RESOURCE_PREFIX stringByAppendingString:goods.gs_dtl_path]]];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake((Main_Screen_Width - 30) * 0.5, 230);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
