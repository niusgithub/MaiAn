//
//  ZXProfileTVC.m
//  ZXChunYu
//
//  Created by yunmu on 15/11/27.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXProfileTVC.h"
#import "ZXLoginVC.h"
#import "ZXUserInfoTVC.h"
#import "ZXFolloweeTVC.h"

#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXUserProfileCell.h"
#import "ZXProfileTool.h"

#import "UIImage+ZX.h"
#import "UIImageView+ZXBorder.h"

#import "MBProgressHUD+MJ.h"
#import <AssetsLibrary/AssetsLibrary.h>

static NSString *const mineCellIdentifier = @"MCellID";

@interface ZXProfileTVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, ZXLoginVCDidLoggedInDelegate, ZXUserInfoTVCDelegate, ZXUserProfileCellDelegate>

@property (nonatomic, strong) ZXLoginVC *loginVC;
@property (nonatomic, strong) ZXUserProfileCell *profileCell;
@property BOOL hasLoggedIn;

@end


@implementation ZXProfileTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    self.title = @"个人中心";
    
    if ([ZXAccountTool shareAccount]) {
        self.hasLoggedIn = YES;
    } else {
        self.hasLoggedIn = NO;
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:kUPCellNibName bundle:nil] forCellReuseIdentifier:kUPCellIdentifier];
}


#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZXUserProfileCell *cell = (ZXUserProfileCell *)[self.tableView dequeueReusableCellWithIdentifier:kUPCellIdentifier];
        self.profileCell = cell;
        cell.delegate = self;
        if (_hasLoggedIn) {
            [cell configureUserProfileCellWithAccount:[ZXAccountTool shareAccount]];
        }
        return cell;
    }
    
    // section 1
    switch (indexPath.row) {
        case 0: {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellIdentifier];
            [cell.imageView setImage:[UIImage imageNamed:@"mineDoctor"]];
            cell.textLabel.text = @"我的医生";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
            break;
        case 1: {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellIdentifier];
            [cell.imageView setImage:[UIImage imageNamed:@"mineQuestion"]];
            cell.textLabel.text = @"我的提问";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
            break;
        case 2: {
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellIdentifier];
            [cell.imageView setImage:[UIImage imageNamed:@"mineSetting"]];
            cell.textLabel.text = @"我的设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
            break;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return kUPCellHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 20;
    }
    return 0;
}


#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if (_hasLoggedIn) { // 已登录，跳转至个人中心
                ZXUserInfoTVC *vc = [[ZXUserInfoTVC alloc] init];
                vc.delegate = self;
                [self.navigationController pushViewController:vc animated:YES];
            } else { // 未登录，跳转至登录
                UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"ZXLoginStoryboard" bundle:nil];
                _loginVC = [loginStoryboard instantiateInitialViewController];
                _loginVC.delegate = self;
                
                UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:_loginVC];
                navi.navigationBarHidden = YES;
                
                [self presentViewController:navi animated:YES completion:nil];
            }
        }
            break;
            
        case 1: {
            if (_hasLoggedIn) {
                switch (indexPath.row) {
                    case 0: {
                        ZXFolloweeTVC *tvc = [[ZXFolloweeTVC alloc] init];
                        [self.navigationController pushViewController:tvc animated:YES];
                    }
                        break;
                        
                    case 1: {
                    }
                        break;
                    
                    case 2: {
                    }
                        break;
                }
            } else {
                [MBProgressHUD showError:@"请先登录"];
            }
            
        }
            break;
    }
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 1.取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 2.压缩图片
    NSLog(@"selected image:%@", image);
    
    UIImage *newImage = [[image largestCenteredSquareImage] resizeToTargetSize:CGSizeMake(200, 200)];
    
    NSLog(@"new image:%@", newImage);
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.7);
    
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    NSString *imageName = [NSString stringWithFormat:@"iOS_%@_%@.jpg", [ZXAccountTool shareAccount].uid, currentTime];
    
    NSLog(@"imageName:%@",imageName);
    
    [ZXProfileTool UploadAvatarWithAccount:[ZXAccountTool shareAccount] imageName:imageName imageData:imageData success:^(id responseObj) {
//FIXME:要服务器返回新的头像地址
        [self.tableView reloadData];
    } failure:^(NSError *error) {
    
    }];

    /*
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    [assetsLibrary assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset) {
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        float fileMB = (float)([representation size] / 1024.0 / 1024.0 );
        
        NSData *imageData;
        
        if (fileMB > 2.0) {
            imageData = UIImageJPEGRepresentation(image, 1.9 / fileMB);
        } else {
            // 没有压缩
            imageData = UIImagePNGRepresentation(image);
        }
        
        NSString *fileName = [representation filename];
        
        NSLog(@"fileName : %@",fileName);

        NSLog(@"size of asset in bytes: %0.2f ysb:%f", fileMB, 1.9 / fileMB);
    } failureBlock:^(NSError *error) {
        NSLog(@"获取图片资源失败:%@", error);
    }];
     */
}


#pragma mark - UIActionSheetDelegate 

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: { //打开照相机
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
            
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
        }
            break;
        case 1: { // 打开相册
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
            
            UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.delegate = self;
            [self presentViewController:ipc animated:YES completion:nil];
        }
            break;
    }
}


#pragma mark - ZXLoginVCDidLoggedInDelegate

- (void)didLoggedIn {
    self.hasLoggedIn = YES;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - ZXUserInfoTVCDelegate

- (void)toLogoutStatus {
     self.hasLoggedIn = NO;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - ZXUserProfileCellDelegate

- (void)changeUserAvatar {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照选取", @"相册选取" ,nil];
    [sheet showInView:self.view];
}

@end
