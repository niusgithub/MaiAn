//
//  ZXSearch4HosTVC.m
//  ZXChunYu
//
//  Created by yunmu on 16/1/19.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import "ZXSearch4HosTVC.h"

#import "ZXHospitalTVC.h"

#import "ZXRDTableViewCell.h"
#import "ZXSearchMenuView.h"

#import "ZXHospital.h"

#import "ZXCommon.h"
#import "UIColor+ZX.h"

#import "ZXSearch4HosTool.h"

#import "YYModel.h"
#import "MBProgressHUD+MJ.h"

@interface ZXSearch4HosTVC () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UIScrollViewDelegate, ZXSearchMenuViewDelegate>

// our secondary search results table view
@property (nonatomic, strong) UISearchController *searchController;
//@property (nonatomic, strong) ZXS4DResultTVC *resultTVC;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

// 网络请求状态
@property BOOL isSearchThreahActive;

@property BOOL showHeaderMenu;

@end


@interface ZXSearch4HosTVC ()

@end


@implementation ZXSearch4HosTVC

#pragma mark - View

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getHospitals];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找医院";
    self.isSearchThreahActive = NO;
    self.showHeaderMenu = NO;
    
    //self.tableView.bounces = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:kRDTableCellNibName bundle:nil] forCellReuseIdentifier:kRDCellIdentifier];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.placeholder = @"搜索医院名称";
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    self.searchController.searchBar.tintColor = [UIColor themeColor];
    
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    self.definesPresentationContext = YES; // know where you want UISearchController to be displayed
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

#pragma mark - 

- (void)getHospitals {
    
    [self.hospitals removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:NSLocalizedString(@"loading", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [ZXSearch4HosTool getHospitalsByNumber:@0 successBlock:^(id responseObject) {
//            NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSLog(@"ZXHospital:%@",rStr);
            NSDictionary *hosInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            for (NSDictionary *docDict in hosInfoJson) {
                @autoreleasepool {
                    ZXHospital *hos = [ZXHospital yy_modelWithDictionary:docDict];
                    [self.hospitals addObject:hos];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                [hud hide:YES];
            });
        } failureBlock:^(NSError *error) {
            NSLog(@"getHospitalsByNumber ERR:%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [MBProgressHUD showError:@"找医院数据请求失败!"];
            });
        }]; 
    });
}


#pragma mark - init

- (NSMutableArray *)hospitals {
    if (!_hospitals) {
        _hospitals = [[NSMutableArray alloc] init];
    }
    return _hospitals;
}


#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.showHeaderMenu = YES;
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.showHeaderMenu = NO;
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


#pragma mark - TableView Delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXHospital *hos = self.hospitals[indexPath.row];
    ZXHospitalTVC *vc = [[ZXHospitalTVC alloc] initWithHospital:hos];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.hospitals.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRDTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXRDTableViewCell *cell = (ZXRDTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kRDCellIdentifier forIndexPath:indexPath];
    
    if (self.hospitals.count > 0) {
        ZXHospital *hos = self.hospitals[indexPath.row];
        [cell configureRDCellWithHospital:hos];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.showHeaderMenu && section == 0) {
        ZXSearchMenuView *v = [[ZXSearchMenuView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30) andType:ZXSearchMenuHospital];
        v.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        v.delegate = self;
        return v;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.showHeaderMenu && section == 0) {
        return 30;
    }
    return 0;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    if (self.isSearchThreahActive) {
        // Do something...
        //self.isSearchThreahActive = NO;
    } else {
        //self.isSearchThreahActive = YES;
        [self.hospitals removeAllObjects];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:NSLocalizedString(@"loading", nil)];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [ZXSearch4HosTool getHospitalsByName:self.searchController.searchBar.text andStartNum:@0 successBlock:^(id responseObject) {
                NSDictionary *hosInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                for (NSDictionary *hosDict in hosInfoJson) {
                    ZXHospital *hos = [ZXHospital yy_modelWithDictionary:hosDict];
                    [self.hospitals addObject:hos];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                    [hud hide:YES];
                });
            } failureBlock:^(NSError *error) {
                NSLog(@"getHospitalsByName ERR:%@",error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hide:YES];
                    [MBProgressHUD showError:@"找医院数据请求失败!"];
                });
            }];
        });
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchController.searchBar endEditing:YES];
}

#pragma mark - ZXSearchMenuViewDelegate

- (void)updateDataByArea:(NSString *)area {
    
    self.searchController.searchBar.text = [NSString stringWithFormat:@"%@", area];
    
    [self.hospitals removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:NSLocalizedString(@"loading", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [ZXSearch4HosTool getHospitalsByArea:area andStartNum:@0 successBlock:^(id responseObject) {
            
            NSDictionary *hosInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            for (NSDictionary *hosDict in hosInfoJson) {
                ZXHospital *hos = [ZXHospital yy_modelWithDictionary:hosDict];
                [self.hospitals addObject:hos];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                [hud hide:YES];
            });
        } failureBlock:^(NSError *error) {
            NSLog(@"getDoctorWithName ERR:%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [MBProgressHUD showError:@"找医生数据请求失败!"];
            });
        }];
    });
}

- (void)updateDataByTitle:(NSString *)title {
    
    self.searchController.searchBar.text = [NSString stringWithFormat:@"%@", title];
    
    [self.hospitals removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:NSLocalizedString(@"loading", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ZXSearch4HosTool getHospitalsByTitle:title andStartNum:@0 successBlock:^(id responseObject) {
            
            NSDictionary *hosInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            for (NSDictionary *hosDict in hosInfoJson) {
                ZXHospital *hos = [ZXHospital yy_modelWithDictionary:hosDict];
                [self.hospitals addObject:hos];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
                [hud hide:YES];
            });
        } failureBlock:^(NSError *error) {
            NSLog(@"getDoctorWithName ERR:%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES];
                [MBProgressHUD showError:@"找医生数据请求失败!"];
            });
        }];
    });
}


@end
