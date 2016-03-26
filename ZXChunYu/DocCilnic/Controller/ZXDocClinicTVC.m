//
//  ZXDocCilnicTVC.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/28.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXCommon.h"

#import "ZXDocClinicTVC.h"
#import "ZXUserEvaluationTVC.h"

#import "ZXDoctor.h"
#import "ZXDoctorComment.h"

#import "ZXGetDocComments.h"

#import "ZXDocClinicDoctorCell.h"
#import "ZXDocClinicServiceCell.h"
#import "ZXDocClinicTitleCell.h"

#import "NSString+ZX.h"

#import "YYModel.h"

NSString *const kDocClinicDoctorCellIdentifier = @"DCDCellID";
NSString *const kDocClinicDoctorCellNibName = @"ZXDocClinicDoctorCell";
NSString *const kDocClinicServiceCellIdentifier = @"DCSCellID";
NSString *const kDocClinicServiceCellNibName = @"ZXDocClinicServiceCell";
NSString *const kDocClinicTitleCellIdentifier = @"DCTCellID";
NSString *const kDocClinicTitleCellNibName = @"ZXDocClinicTitleCell";

@interface ZXDocClinicTVC ()
@property (nonatomic, strong) ZXDoctor *doctor;
@property (nonatomic, strong) NSMutableArray *doctorComments;
@end

@implementation ZXDocClinicTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView registerNib:[UINib nibWithNibName:kDocClinicDoctorCellNibName bundle:nil] forCellReuseIdentifier:kDocClinicDoctorCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:kDocClinicServiceCellNibName bundle:nil] forCellReuseIdentifier:kDocClinicServiceCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:kDocClinicTitleCellNibName bundle:nil] forCellReuseIdentifier:kDocClinicTitleCellIdentifier];
    
    [self getDoctorComments];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] init];
    btn.title = @"返回";
    self.navigationItem.backBarButtonItem = btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)getDoctorComments {
    [ZXGetDocComments getDoctorCommentsWithDID:self.doctor.did startNum:@0 successBlock:^(id responseObject) {
//        NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"getDoctorComments_responseObject:%@",rStr);
        
        NSDictionary *docCommnetsJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        for (NSDictionary *commentDict in docCommnetsJson) {
            ZXDoctorComment *comment = [ZXDoctorComment yy_modelWithDictionary:commentDict];
            [self.doctorComments addObject:comment];
        }
        
        [self.tableView reloadData];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"getDoctorComments_ERR:%@",error);
    }];
}

#pragma mark - init

- (NSMutableArray *)doctorComments {
    if (!_doctorComments) {
        _doctorComments = [NSMutableArray array];
    }
    return _doctorComments;
}

- (instancetype)initClinicWithDoctor:(ZXDoctor *)doctor {
    if (self = [super init]) {
        //_doctor = [doctor copy];
        // retain
        _doctor = doctor;
        self.title = [NSString stringWithFormat:@"%@%@诊所", doctor.dc_name ,doctor.dc_department];
    }
    return self;
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
        case 1:
            return 1;
        case 2:
            return 2;
        case 3:
            // 诊所界面最多显示两条最近评论
            return (self.doctorComments.count + 1)>3 ? 3 : self.doctorComments.count + 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0: {
            ZXDocClinicDoctorCell *cell = (ZXDocClinicDoctorCell *)[self.tableView dequeueReusableCellWithIdentifier:kDocClinicDoctorCellIdentifier];
            
            // 判断是否关注该医生
            
            
            [cell configureDCDCellWithDoctor:self.doctor];
            
            return cell;
        }
            
        case 1: {
            ZXDocClinicServiceCell *cell = (ZXDocClinicServiceCell *)[self.tableView dequeueReusableCellWithIdentifier:kDocClinicServiceCellIdentifier];
            
            return cell;
        }
        
        case 2: {
            if (indexPath.row == 0) {
                ZXDocClinicTitleCell *cell = (ZXDocClinicTitleCell *)[self.tableView dequeueReusableCellWithIdentifier:kDocClinicTitleCellIdentifier];
                [cell configureDCTCellWithTitle:@"医生详情" andMore:@"查看全部"];
                
                return cell;
            } else {
                // 原版此处根据简介内容多少调整cell高度
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ZXTitleCellID"];
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = ZXGrayColor;
                cell.textLabel.numberOfLines = 3;
                cell.textLabel.text = self.doctor.dc_desc;
                
                return cell;
            }
            
        }
            
        case 3: {
            if (indexPath.row == 0) {
                ZXDocClinicTitleCell *cell = (ZXDocClinicTitleCell *)[self.tableView dequeueReusableCellWithIdentifier:kDocClinicTitleCellIdentifier];
                [cell configureDCTCellWithTitle:@"用户评价" andMore:@"全部评论"];
                return cell;
            } else {
                // 原版此处根据简介内容多少调整cell高度
                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ZXCommentCellID"];
                
                cell.textLabel.numberOfLines = 1;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                
                cell.detailTextLabel.textColor = ZXGrayColor;
                cell.detailTextLabel.numberOfLines = 3;
                cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
                
                if (self.doctorComments.count > 0) {
                    ZXDoctorComment *comment = self.doctorComments[indexPath.row-1]; // 评论的cell是从第1个row开始的，第0个是标题cell
                    cell.textLabel.text = [NSString stringWithFormat:@"%@    %@分", comment.username, comment.score];
                    cell.detailTextLabel.text = comment.content;
                    
                    CGSize titleSize = [cell.textLabel.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
                    CGSize commentSize = [cell.detailTextLabel.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
                    
                    if (indexPath.row != self.doctorComments.count) {
                        // 添加分割线
                        UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(10, titleSize.height + commentSize.height + kCellMargin, 355, 1)];
                        seperator.backgroundColor = [UIColor blackColor];
                        seperator.alpha = 0.1f;
                        [cell.contentView addSubview:seperator];
                    }
                }
                return cell;
            }
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 145;
        case 1:
            return 100;
        case 2:
            if (indexPath.row == 0)
                return 30;
        case 3:
            if (indexPath.row == 0) {
                return 30;
            } else {
                if (self.doctorComments.count > 0) {
                    ZXDoctorComment *comment = self.doctorComments[indexPath.row-1]; // 评论的cell是从第1个row开始的，第0个是标题cell
                    
                    CGSize titleSize = [[NSString stringWithFormat:@"%@    %@分", comment.username, comment.score] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
                    CGSize commentSize = [comment.content sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
                    
                    return titleSize.height + commentSize.height + kCellMargin;
                }
            }
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 10;
    }
    return 0;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 医生详情由于信息不足 暂不实现
    
    // 评论列表
    if (indexPath.section == 3) {
        if (indexPath.row == 0 && self.doctorComments.count > 0) {
            // 查看全部评价
            ZXUserEvaluationTVC *tvc = [[ZXUserEvaluationTVC alloc] init];
            tvc.comments = self.doctorComments;
            [self.navigationController pushViewController:tvc animated:YES];
        }
    }
}

@end
