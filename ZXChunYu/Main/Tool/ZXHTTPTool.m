//
//  ZXHTTPTool.m
//  ZXChunYu
//
//  Created by yunmu on 15/12/16.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#import "ZXHTTPTool.h"
#import "ZXLoginParams.h"
#import "AFNetworking.h"


@implementation ZXHTTPTool

+ (void)POST:(NSString *)URL params:(NSObject *)paramsObj success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mgr POST:URL parameters:paramsObj progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        //[NSException raise:NSGenericException format:@"ZXHTTPTool POST ERR"];
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URL
         UID:(NSString *)uid
         KEY:(NSString *)key
      params:(NSObject *)paramsObj
     success:(void(^)(id responseObj))success
     failure:(void(^)(NSError *err))failure; {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mgr.requestSerializer setValue:uid forHTTPHeaderField:@"UID"];
    [mgr.requestSerializer setValue:key forHTTPHeaderField:@"KEY"];
    
    [mgr POST:URL parameters:paramsObj progress:^(NSProgress * uploadProgress) {
        
    } success:^(NSURLSessionDataTask * task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        //[NSException raise:NSGenericException format:@"ZXHTTPTool POST ERR"];
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)GET:(NSString *)URL params:(NSObject *)paramsObj success:(void(^)(id))success failure:(void(^)(NSError *))failure {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
   
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mgr GET:URL parameters:paramsObj progress:^(NSProgress * downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)GET:(NSString *)URL
        UID:(NSString *)uid
        KEY:(NSString *)key
     params:(NSObject *)paramsObj
    success:(void(^)(id))success
    failure:(void(^)(NSError *))failure {
    
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mgr.requestSerializer setValue:uid forHTTPHeaderField:@"UID"];
    [mgr.requestSerializer setValue:key forHTTPHeaderField:@"KEY"];
    
    [mgr GET:URL parameters:paramsObj progress:^(NSProgress * downloadProgress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)UploadImageWithURL:(NSString *)URL
                       UID:(NSString *)uid
                       KEY:(NSString *)key
                    params:(NSObject *)paramsObj
                 imageName:(NSString *)imageName
                 imageData:(NSData *)imageData
                   success:(void(^)(id responseObj))success
                   failure:(void(^)(NSError *err))failure; {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:uid forHTTPHeaderField:@"UID"];
    [manager.requestSerializer setValue:key forHTTPHeaderField:@"KEY"];
    
    [manager POST:URL parameters:paramsObj constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        //将得到的二进制图片拼接到表单中 /** data,指定上传的二进制流;name,服务器端所需参数名;fileName,指定文件名;mimeType,指定文件格式 */
        
        [formData appendPartWithFileData:imageData name:imageName fileName:imageName mimeType:@"image/*"];
        
        //多用途互联网邮件扩展（MIME，Multipurpose Internet Mail Extensions）
    } progress:^(NSProgress *uploadProgress) {
        // NSLog(@"uploadProgress--%@", uploadProgress);
        /*
         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
         hud.mode = MBProgressHUDModeAnnularDeterminate;
         [hud setLabelText:NSLocalizedString(@"loading", nil)];
         [self doSomethingInBackgroundWithProgressCallback:^(float progress) {
         hud.progress = progress;
         } completionCallback:^{
         [hud hide:YES];
         }];
         */
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        // NSLog(@"upload Success:%@", responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        // NSLog(@"upload failure:%@", error);
        if (failure) {
            failure(error);
        }
    }];
}

//+ (void)UploadImageWithURL:(NSString *)URL params:(NSObject *)paramsObj imageName:(NSString *)imageName imageData:(NSData *)imageData success:(void(^)(id))success failure:(void(^)(NSError *))failure {
//    
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager POST:URL parameters:paramsObj constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithFileData:imageData name:imageName fileName:imageName mimeType:@"image/*"];
//    } progress:^(NSProgress *uploadProgress) {
//        NSLog(@"uploadProgress--%@", uploadProgress);
//    } success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"upload Success:%@", responseObject);
//    } failure:^(NSURLSessionDataTask *task, NSError * error) {
//        NSLog(@"upload failure:%@", error);
//    }];
//}

@end











