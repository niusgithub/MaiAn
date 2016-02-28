//
//  ZXUserEvaluationTVC.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/6.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXCommon.h"

#import "ZXUserEvaluationTVC.h"
#import "ZXDoctorComment.h"

#import "NSString+ZX.h"

@implementation ZXUserEvaluationTVC

- (void)viewDidLoad {
    self.title = @"用户评价";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 不显示多余空白cell
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

#pragma mark - TableView DataSource

//FIXME:没有做分页和下拉刷新
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ZXCommentCellID"];
    
    cell.textLabel.numberOfLines = 1;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.detailTextLabel.textColor = ZXGrayColor;
    cell.detailTextLabel.numberOfLines = 3;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    
    if (self.comments.count > 0) {
        ZXDoctorComment *comment = self.comments[indexPath.row]; // 评论的cell是从第1个row开始的，第0个是标题cell
        cell.textLabel.text = [NSString stringWithFormat:@"%@    %@分", comment.username, comment.score];
        cell.detailTextLabel.text = comment.content;
        
        CGSize titleSize = [cell.textLabel.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
        CGSize commentSize = [cell.detailTextLabel.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
        
        if (indexPath.row != self.comments.count - 1) {
            // 添加分割线
            UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(10, titleSize.height + commentSize.height + kCellMargin, 355, 1)];
            seperator.backgroundColor = [UIColor blackColor];
            seperator.alpha = 0.1f;
            [cell.contentView addSubview:seperator];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.comments.count > 0) {
        ZXDoctorComment *comment = self.comments[indexPath.row];
        
        CGSize titleSize = [[NSString stringWithFormat:@"%@    %@分", comment.username, comment.score] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
        CGSize commentSize = [comment.content sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(200, CGFLOAT_MAX)];
        
        return titleSize.height + commentSize.height + kCellMargin;
    }
    return 0;
}
@end
