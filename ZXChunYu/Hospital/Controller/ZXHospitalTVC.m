//
//  ZXHospitalTVC.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/19.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXHospitalTVC.h"
#import "ZXDocClinicTVC.h"

#import "ZXHospital.h"
#import "ZXDoctor.h"

#import "ZXHosMainCell.h"
#import "ZXHosTitleCell.h"
#import "ZXRDTableViewCell.h"

#import "ZXGetDocExtraInfo.h"

#import "NSString+ZX.h"


@interface ZXHospitalTVC ()

@property (nonatomic, strong) ZXHospital *hospital;

@end


@implementation ZXHospitalTVC

#pragma mark - View

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 0.01f)];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView registerNib:[UINib nibWithNibName:kHosMainCellNibName bundle:nil] forCellReuseIdentifier:kHosMainCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:kHosTitleCellNibName bundle:nil] forCellReuseIdentifier:kHosTitleCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:kRDTableCellNibName bundle:nil] forCellReuseIdentifier:kRDCellIdentifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self getDoctorComments];
}

#pragma mark - init

- (instancetype)initWithHospital:(ZXHospital *)hospital {
    if (self = [super init]) {
        _hospital = hospital;
        self.title = hospital.hs_name;
    }
    return self;
}

#pragma mark - TableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0: {
            ZXHosMainCell *cell = (ZXHosMainCell *)[self.tableView dequeueReusableCellWithIdentifier:kHosMainCellIdentifier];
            [cell configureHMCellWithHospital:self.hospital];
            return cell;
        }
            
        case 1: {
            if (indexPath.row == 0) {
                ZXHosTitleCell *cell = (ZXHosTitleCell *)[self.tableView dequeueReusableCellWithIdentifier:kHosTitleCellIdentifier];
                
                [cell configureCellWithTitle:@"医院详情"];
                
                return cell;
            }
            
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
            cell.textLabel.text = self.hospital.hs_desc;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.numberOfLines = 0;
            return cell;
        }
            
        case 2: {
            if (indexPath.row == 0) {
                ZXHosTitleCell *cell = (ZXHosTitleCell *)[self.tableView dequeueReusableCellWithIdentifier:kHosTitleCellIdentifier];
                
                [cell configureCellWithTitle:@"本院名医"];
                
                return cell;
            }
            
            ZXRDTableViewCell *cell = (ZXRDTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kRDCellIdentifier forIndexPath:indexPath];
            
            if (self.hospital.hs_docs.count > 0) {
                ZXDoctor *doc = self.hospital.hs_docs[indexPath.row - 1];
                
                //粉丝数
                [ZXGetDocExtraInfo getDoctorFollowerNumberWithDID:doc.did successBlock:^(id responseObject) {
                    //                NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    //                NSLog(@"followerNum:%@",rStr);
                    NSDictionary *followerNum = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    // followerNum[@"num"] 类型为NSNumber 可以打印 不能赋值给NSString
                    doc.followerNum = [followerNum[@"num"] stringValue];
                } failureBlock:^(NSError *error) {
                    NSLog(@"getDoctorExtraInfo--followerNum ERR:%@",error);
                }];
                
                //服务人数
                [ZXGetDocExtraInfo getDoctorServeNumberWithDID:doc.did successBlock:^(id responseObject) {
                    //                NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    //                NSLog(@"serveNum:%@",rStr);
                    NSDictionary *serveNum = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    // serveNum[@"num"] 类型为NSNumber 可以打印 不能赋值给NSString
                    doc.serveNum = [serveNum[@"num"] stringValue];
                } failureBlock:^(NSError *error) {
                    NSLog(@"getDoctorExtraInfo--serveNum ERR:%@",error);
                }];
                
                [cell configureRDCellWithDoctor:doc];
            }
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return kHosMainCellHeight;
            
        case 1: {
            if (indexPath.row == 0) {
                return kHosTitleCellHeight;
            }
            
            if (indexPath.row == 1) {
                
                CGSize textSize = [self.hospital.hs_desc sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(350, CGFLOAT_MAX)];
                return textSize.height + 30;
            }
        }
            
        case 2: {
            if (indexPath.row == 0) {
                return kHosTitleCellHeight + 1;
            }
            return kRDTableCellHeight;
        }
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            
        case 1:
            return 2;
            
        case 2:
            return self.hospital.hs_docs.count < 5 ?  self.hospital.hs_docs.count + 1 : 6;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 10;
    }
    return 0;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        
        if (indexPath.row != 0) {
            // 打开对应的医生的诊所
            ZXDoctor *doc = self.hospital.hs_docs[indexPath.row - 1];
            ZXDocClinicTVC *vc = [[ZXDocClinicTVC alloc] initClinicWithDoctor:doc];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
