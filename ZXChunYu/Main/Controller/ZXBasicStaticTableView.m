//
//  ZXBasicTableView.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/2.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXBasicStaticTableView.h"
#import "ZXTableViewGroup.h"
#import "ZXTableViewCell.h"
#import "ZXTableViewGroup.h"
#import "ZXTableViewItem.h"

#import "ZXCommon.h"

@interface ZXBasicStaticTableView ()
@property (nonatomic, strong) NSMutableArray *groups;
@end

@implementation ZXBasicStaticTableView

- (NSMutableArray *)groups {
    if (!_groups) {
        self.groups = [NSMutableArray array];
    }
    return _groups;
}

// 屏蔽tableview样式
- (id)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 隐藏滚动条
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 隐藏GroupedTableView上边多余的间隔
    CGRect frame = CGRectMake(0, 0, 0, CGFLOAT_MIN);
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:frame];
    
    
    // 设置tableview的属性
    self.tableView.backgroundColor = tableViewBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.tableView.sectionFooterHeight = HMStatusCellMargin;
//    self.tableView.sectionHeaderHeight = 0;
//    self.tableView.contentInset = UIEdgeInsetsMake(HMStatusCellMargin - 35, 0, 0, 0);
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZXTableViewGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXTableViewCell *cell = [ZXTableViewCell cellWithTableView:tableView];
    ZXTableViewGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    // 设置cell所处的行号和所处组的总行数
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ZXTableViewGroup *group = self.groups[section];
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    ZXTableViewGroup *group = self.groups[section];
    return group.footer;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取出cell对应的item模型
    ZXTableViewGroup *group = self.groups[indexPath.section];
    ZXTableViewItem *item = group.items[indexPath.row];
    
    // 判断是否有需要跳转的控制器
    if (item.destVCClass) {
        UIViewController *destVC = [[item.destVCClass alloc] init];
        destVC.title = item.title;
        [destVC.view setBackgroundColor:[UIColor lightGrayColor]];
        [self.navigationController pushViewController:destVC animated:YES];
    }
    
    // 判断要执行的操作
    if (item.operation) {
        item.operation();
    }
}

@end







