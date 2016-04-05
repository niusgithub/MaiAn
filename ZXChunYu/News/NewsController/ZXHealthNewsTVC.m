//
//  ZXHealthNewsTVC.m
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXHealthNewsTVC.h"
#import "ZXHealthNewsTool.h"
#import "ZXHealthNews.h"

#import "ZXCommon.h"
#import "ZXMaiAnAPI.h"
#import <SafariServices/SafariServices.h>

#import "YYModel.h"
#import "MBProgressHUD+MJ.h"

static NSString *kNewsCellID = @"NewsCell";

@interface ZXHealthNewsTVC ()
@property (nonatomic, copy) NSString *typeString;
@end

@implementation ZXHealthNewsTVC

- (instancetype)initWithHealthNewsType:(ZXHealthNewsType)type {
    if (self = [super init]) {
        
        self.needHeaderRefresher = YES;
        
        switch (type) {
            case ZXHealthNewsCommomSense:
                _typeString = @"基本常识";
                break;
                
            case ZXHealthNewsSymoptom:
                _typeString = @"临床症状";
                break;
                
            case ZXHealthNewsDiagnosis:
                _typeString = @"诊断治疗";
                break;
                
            case ZXHealthNewsPrevention:
                _typeString = @"预防保健";
                break;
        }
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [ZXHealthNewsTool getArticlesByType:self.typeString startNumber:@0 successBlock:^(id responseObject) {
//            NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSLog(@"getArticle_responseObject:%@",rStr);
            
            NSDictionary *newsJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            for (NSDictionary *newsDict in newsJson) {
                @autoreleasepool {
                    ZXHealthNews *news = [ZXHealthNews yy_modelWithDictionary:newsDict];
                    [self.serverResponseObjects addObject:news];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [hud hide:YES];
            });
        } failureBlock:^(NSError *error) {
            NSLog(@"getArticlesByType ERROR:%@", error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [MBProgressHUD showError:@"健康资讯数据请求失败!"];
            });
        }]; 
    });
}


#pragma mark - TableVeiw DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.serverResponseObjects.count > 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kNewsCellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        ZXHealthNews *news = self.serverResponseObjects[indexPath.row];
        
        cell.textLabel.text = news.art_title;
        cell.detailTextLabel.text = news.art_time;
        
        return cell;
    }
    return nil;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXHealthNews *news = self.serverResponseObjects[indexPath.row];
    
    if (System_Version >= 9.0) {
        SFSafariViewController *safariViewController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[ZXMaiAn_RESOURCE_PREFIX stringByAppendingString:news.art_dtl_path]] entersReaderIfAvailable:YES];
        [self presentViewController:safariViewController animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ZXMaiAn_RESOURCE_PREFIX stringByAppendingString:news.art_dtl_path]]];
    }
}

@end
