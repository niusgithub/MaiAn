//
//  ZXSearch4DocTVC.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/10.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXSearch4DocTVC.h"

#import "ZXRDTableViewCell.h"
#import "ZXDocClinicTVC.h"
#import "ZXSearchMenuView.h"

#import "ZXDoctor.h"

#import "ZXCommon.h"
#import "UIColor+ZX.h"

#import "ZXGetDocExtraInfo.h"
#import "ZXSearch4DocTool.h"

#import "YYModel.h"
#import "MBProgressHUD+MJ.h"

@interface ZXSearch4DocTVC () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UIScrollViewDelegate, ZXSearchMenuViewDelegate>

@property (nonatomic, strong) ZXSearchMenuView *menuView;

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



@implementation ZXSearch4DocTVC

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"找医生";
    self.isSearchThreahActive = NO;
    self.showHeaderMenu = NO;
    
    //self.tableView.bounces = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:kRDTableCellNibName bundle:nil] forCellReuseIdentifier:kRDCellIdentifier];
    
    // _resultTVC = [[ZXS4DResultTVC alloc] init];
    // _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultTVC];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.placeholder = @"搜索医生姓名";
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.searchController.searchBar.barTintColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1];
    self.searchController.searchBar.tintColor = [UIColor themeColor];
    
    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    
    // self.resultTVC.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    // S4D is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES; // know where you want UISearchController to be displayed
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // restore the searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
}

#pragma mark - init

- (NSMutableArray *)recommendedDoctors {
    if (!_recommendedDoctors) {
        _recommendedDoctors = [[NSMutableArray alloc] init];
    }
    return _recommendedDoctors;
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

#pragma mark - UISearchControllerDelegate

// Called after the search controller's search bar has agreed to begin editing or when
// 'active' is set to YES.
// If you choose not to present the controller yourself or do not implement this method,
// a default presentation is performed on your behalf.
//
// Implement this method if the default presentation is not adequate for your purposes.
//
- (void)presentSearchController:(UISearchController *)searchController {

}

- (void)willPresentSearchController:(UISearchController *)searchController {
    // do something before the search controller is presented
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    // do something after the search controller is presented
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    // do something before the search controller is dismissed
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    // do something after the search controller is dismissed
}


#pragma mark - TableView Delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXDoctor *doc = self.recommendedDoctors[indexPath.row];
    ZXDocClinicTVC *vc = [[ZXDocClinicTVC alloc] initClinicWithDoctor:doc];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.recommendedDoctors.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRDTableCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXRDTableViewCell *cell = (ZXRDTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kRDCellIdentifier forIndexPath:indexPath];
    
    if (self.recommendedDoctors.count > 0) {
        ZXDoctor *doc = self.recommendedDoctors[indexPath.row];
        
        //粉丝数
        [ZXGetDocExtraInfo getDoctorFollowerNumberWithDID:doc.did successBlock:^(id responseObject) {
            // NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            // NSLog(@"followerNum:%@",rStr);
            NSDictionary *followerNum = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            // followerNum[@"num"] 类型为NSNumber 可以打印 不能赋值给NSString
            doc.followerNum = [followerNum[@"num"] stringValue];
        } failureBlock:^(NSError *error) {
            NSLog(@"getDoctorExtraInfo--followerNum ERR:%@",error);
        }];
        
        //服务人数
        [ZXGetDocExtraInfo getDoctorServeNumberWithDID:doc.did successBlock:^(id responseObject) {
            // NSString *rStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            // NSLog(@"serveNum:%@",rStr);
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.showHeaderMenu && section == 0) {
        _menuView = [[ZXSearchMenuView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 30) andType:ZXSearchMenuDoctor];
        _menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
        _menuView.delegate = self;
        return _menuView;
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
        
        [self.recommendedDoctors removeAllObjects];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:NSLocalizedString(@"loading", nil)];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [ZXSearch4DocTool getDoctorWithName:self.searchController.searchBar.text andStartNum:@0 successBlock:^(id responseObject) {
                NSDictionary *docInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                for (NSDictionary *docDict in docInfoJson) {
                    ZXDoctor *doc = [ZXDoctor yy_modelWithDictionary:docDict];
                    [self.recommendedDoctors addObject:doc];
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
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchController.searchBar endEditing:YES];
}

#pragma mark - ZXSearchMenuViewDelegate

- (void)updateDataByArea:(NSString *)area {

    self.searchController.searchBar.text = [NSString stringWithFormat:@"%@", area];
    
    [self.recommendedDoctors removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:NSLocalizedString(@"loading", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [ZXSearch4DocTool getDoctorWithArea:area andStartNum:@0 successBlock:^(id responseObject) {
            
            NSDictionary *docInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
       
            for (NSDictionary *docDict in docInfoJson) {
                ZXDoctor *doc = [ZXDoctor yy_modelWithDictionary:docDict];
                [self.recommendedDoctors addObject:doc];
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
    
    [self.recommendedDoctors removeAllObjects];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:NSLocalizedString(@"loading", nil)];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [ZXSearch4DocTool getDoctorWithTitle:title andStartNum:@0 successBlock:^(id responseObject) {
            
            NSDictionary *docInfoJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            
            for (NSDictionary *docDict in docInfoJson) {
                ZXDoctor *doc = [ZXDoctor yy_modelWithDictionary:docDict];
                [self.recommendedDoctors addObject:doc];
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
