//
//  TYGSelectMenu.m
//  TYGSelectMenu
//
//  Created by tanyugang on 15/7/6.
//  Copyright (c) 2015年 tanyugang. All rights reserved.
//

#import "TYGSelectMenu.h"
#import "TYGSelectMenuCellTableViewCell.h"

#import "ZXCommon.h"

@implementation TYGSelectMenu {
    NSInteger totalLevel; // 总级别
    UIView *mainView;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        totalLevel = 1;
        self.menuArray = [NSMutableArray arrayWithCapacity:10];
        self.selectedMenuArray = [NSMutableArray arrayWithCapacity:10];
        
        self.titleFont = [UIFont systemFontOfSize:16];
        self.textAlignment = NSTextAlignmentLeft;
        self.maxWidth = CGRectGetWidth(MainFrame);
        self.maxHeight = CGRectGetHeight(MainFrame);
    }
    return self;
}

/**
 *  添加目录
 *  @param childMenu  添加的目录
 *  @param parentMenu 父级目录，当父级目录为nil时，为一级目录
 */
- (void)addChildSelectMenu:(TYGSelectMenuEntity *)childMenu forParent:(TYGSelectMenuEntity *)parentMenu {
    
    if (nil == childMenu) {
        return;
    }
    
    if (nil == parentMenu) {
        //一级目录
        childMenu.level = 1;
        childMenu.id = self.menuArray.count;
        [self.menuArray addObject:childMenu];
    } else {
        childMenu.level = parentMenu.level + 1;
        childMenu.parentMenu = parentMenu;
        childMenu.id = parentMenu.childMenuArray.count;
        
        [parentMenu.childMenuArray addObject:childMenu];
        
        totalLevel = MAX(totalLevel, childMenu.level);
    }
}

/**
 *  删除目录
 *  @param menu 要删除的目录，如果还有子目录，子目录也会一并删除
 */
- (void)removeMenu:(TYGSelectMenuEntity *)menu {
    
    if (nil == menu) {
        return;
    }

    for (int i = 0; i < self.menuArray.count; i++) {
        TYGSelectMenuEntity *tempMenu = [self.menuArray objectAtIndex:i];
        if (menu.id == tempMenu.id) {
            [self.menuArray removeObjectAtIndex:i];
        } else {
            while (tempMenu && tempMenu.childMenuArray.count > 0) {
                for (int j = 0; j < tempMenu.childMenuArray.count; j++) {
                    TYGSelectMenuEntity *temp2 = [tempMenu.childMenuArray objectAtIndex:j];
                    if (menu.id == temp2.id) {
                        [tempMenu.childMenuArray removeObjectAtIndex:j];
                    }
                }
            }
        }
    }
    
    //获取现在的总级数
    totalLevel = 1;
    for (int i = 0; i < self.menuArray.count; i++) {
        TYGSelectMenuEntity *tempMenu = [self.menuArray objectAtIndex:i];
        while (tempMenu && tempMenu.childMenuArray.count > 0) {
            for (int j = 0; j < tempMenu.childMenuArray.count; j++) {
                TYGSelectMenuEntity *temp2 = [tempMenu.childMenuArray objectAtIndex:j];
                totalLevel = MAX(totalLevel, temp2.level);
            }
        }
    }
}


/**
 *  显示
 *  @param view 要显示的视图（如：一个按钮）
 */
- (void)showFromView:(UIView *)view {
    
    //初始化视图
    CGRect rc = [view convertRect:view.frame toView:view.superview];
    
    CGFloat menuX = 0;
    CGFloat menuY = CGRectGetMaxY(rc);
    CGFloat menuW = CGRectGetWidth(MainFrame) - menuX;
    CGFloat menuH = CGRectGetHeight(MainFrame) - menuY;
    
    menuW = MIN(menuW, self.maxWidth);
    menuH = MIN(menuH, self.maxHeight);
    
    if (mainView) {
        [self disMiss];
    } else {
        //初始化数据
        if (self.selectedMenuArray.count == 0) {
            
            TYGSelectMenuEntity *tempMenu = [self.menuArray firstObject];
            [self.selectedMenuArray addObject:tempMenu];
            
            BOOL canNext = YES;
            while (canNext) {
                tempMenu = [tempMenu.childMenuArray firstObject];
                if (tempMenu) {
                    [self.selectedMenuArray addObject:tempMenu];
                } else {
                    canNext = NO;
                }
            }
        }
        
        //CGRect mainViewFrame = CGRectMake(menuX, menuY, menuW, menuH);
        CGRect mainViewFrame = CGRectMake(0, 30, menuW, menuH);
        
        [self drawShowViewWithFrame:mainViewFrame];
        
        mainView.backgroundColor = [UIColor clearColor];
        
        mainView.frame = CGRectMake(menuX, menuY, menuW, 0);
        [UIView animateWithDuration:0.24 animations:^{
            
            mainView.frame = mainViewFrame;
//FIXME:superview
            [view.superview addSubview:mainView];

        } completion:^(BOOL finished) {
            
        }];
    }
}

/**
 *  绘制目录视图
 */
- (UIView *)drawShowViewWithFrame:(CGRect)frame {
    
    if (nil == mainView) {
        mainView = [[UIView alloc] initWithFrame:frame];
        mainView.backgroundColor = [UIColor whiteColor];
        mainView.clipsToBounds = YES;
    } else {
        for (UIView *tempView in mainView.subviews) {
            [tempView removeFromSuperview];
        }
    }
    
    CGFloat scrollOffset_v = 1;
    CGFloat scrollOffset_h = 1;

    CGFloat scrollX = 0;
    CGFloat scrollY = scrollOffset_v;
    CGFloat scrollW = (CGRectGetWidth(mainView.frame) + scrollOffset_h) / totalLevel - scrollOffset_h;
    CGFloat scrollH = CGRectGetHeight(mainView.frame) - scrollY;
    
    for (int i = 0; i < totalLevel; i ++) {
        //滚动视图
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(scrollX, scrollY, scrollW, 200) style:UITableViewStylePlain];

        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (System_Version >= 7.0) {
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        }
        
        [mainView addSubview:tableView];
        
        // 蒙板
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(scrollX-1, scrollY, scrollW+1, scrollH)]; //有个缝😂
        v.backgroundColor = [UIColor blackColor];
        v.alpha = 0.8f;
        [v  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)]];
        [mainView insertSubview:v belowSubview:tableView];
        
        tableView.backgroundColor = [UIColor whiteColor];

        scrollX = CGRectGetMaxX(tableView.frame) + scrollOffset_h;
    }
    return mainView;
}

/**
 *  隐藏
 */
- (void)disMiss {
    
    if (mainView) {
        
        CGRect mainViewFrame = mainView.frame;
        mainViewFrame.size.height = 0;

        [UIView animateWithDuration:0.24 animations:^{
            mainView.frame = mainViewFrame;
        } completion:^(BOOL finished) {
            [mainView removeFromSuperview];
            mainView = nil;
        }];
    }
}

/**
 *  选中目录事件
 *  @param selectedMenu 选中的目录
 */
- (void)selectAtMenu:(void(^)(NSMutableArray *selectedMenuArray))selectedMenu2{
    selectedMenu = selectedMenu2;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger num = 0;
    
    if (tableView.style == UITableViewStylePlain) {
        num = 1;
    } else {
        NSInteger tableLevel = tableView.tag;
        for (int i = 0; i < self.selectedMenuArray.count; i ++) {
            if (tableLevel == i) {
                if (i == 0) {
                    num = self.menuArray.count;
                }
                else{
                    TYGSelectMenuEntity *parMenu = [self.selectedMenuArray objectAtIndex:i-1];
                    num = parMenu.childMenuArray.count;
                }
            }
        }
    }

    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger num = 0;
    
    if (tableView.style == UITableViewStylePlain) {
        NSInteger tableLevel = tableView.tag;
        for (int i = 0; i < self.selectedMenuArray.count; i ++) {
            if (tableLevel == i) {
                if (i == 0) {
                    num = self.menuArray.count;
                }
                else{
                    TYGSelectMenuEntity *parMenu = [self.selectedMenuArray objectAtIndex:i-1];
                    num = parMenu.childMenuArray.count;
                }
            }
        }
    } else {
        num = 1;
    }
    
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdetify = @"TYGSelectMenuCellTableViewCell";
    TYGSelectMenuCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (nil == cell) {
        UINib *nib = [UINib nibWithNibName:@"TYGSelectMenuCellTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:reuseIdetify];
        cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
//    static NSString *reuseIdetify = @"TYGSelectMenu";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
//        cell.showsReorderControl = YES;
//        
//    }
    
    //获取数据
    TYGSelectMenuEntity *tempMenu = nil;
    NSInteger tableLevel = tableView.tag;
    for (int i = 0; i < self.selectedMenuArray.count; i ++) {
        if (tableLevel == i) {
            if (i == 0) {
                tempMenu = [self.menuArray objectAtIndex:indexPath.row];
            }
            else{
                TYGSelectMenuEntity *parMenu = [self.selectedMenuArray objectAtIndex:i-1];
                tempMenu = [parMenu.childMenuArray objectAtIndex:indexPath.row];
            }
        }
    }
    
    //选中的数据
    TYGSelectMenuEntity *tempActionMenu = [self.selectedMenuArray objectAtIndex:tableLevel];
    
    //显示数据
//    if (tempActionMenu.id == tempMenu.id) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        cell.backgroundColor = [UIColor whiteColor];
//    }
//    else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.backgroundColor = [UIColor whiteColor];
//    }
//    
//    cell.textLabel.text = tempMenu.title;
    
    //显示数据
    if (tempActionMenu.id == tempMenu.id) {
        cell.isSelected = YES;
    } else {
        cell.isSelected = NO;
    }
    
    cell.titleLabel.text = tempMenu.title;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //获取选中的节点
    TYGSelectMenuEntity *tempMenu = nil;
    NSInteger tableLevel = tableView.tag;
    for (int i = 0; i < self.selectedMenuArray.count; i ++) {
        if (tableLevel == i) {
            if (i == 0) {
                tempMenu = [self.menuArray objectAtIndex:indexPath.row];
            }
            else{
                TYGSelectMenuEntity *parMenu = [self.selectedMenuArray objectAtIndex:i-1];
                tempMenu = [parMenu.childMenuArray objectAtIndex:indexPath.row];
            }
        }
    }
    
    [self.selectedMenuArray replaceObjectAtIndex:tableLevel withObject:tempMenu];
    [tableView reloadData];

    //刷新选中的节点的子节点
    if (tempMenu && tempMenu.childMenuArray.count > 0) {
        
        while (tempMenu && tempMenu.childMenuArray.count > 0) {
            
            tempMenu = [tempMenu.childMenuArray firstObject];
            
            [self.selectedMenuArray replaceObjectAtIndex:tableLevel + 1 withObject:tempMenu];
            
            UITableView *tempTable = (UITableView *)[mainView viewWithTag:tableLevel + 1];
            if (tempTable) {
                [tempTable reloadData];
            }
            tableLevel++;
        }
    } else {
        if (selectedMenu) {
            selectedMenu(self.selectedMenuArray);
            
            [self disMiss];
        }
    }
}

@end
