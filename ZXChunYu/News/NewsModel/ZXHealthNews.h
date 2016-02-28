//
//  ZXHealthNews.h
//  ZXChunYu
//
//  Created by 陈知行 on 16/2/1.
//  Copyright © 2016年 陈知行. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXHealthNews : NSObject

// {"art_id":78,"art_title":"孕期莫经常站立","art_type":"基本常识","art_dtl_path":"/html/encyclopedia_html/116112162549157/yq.html","art_time":"Jan 12, 2016 4:25:54 PM"}

@property (nonatomic, copy) NSString *art_id;
@property (nonatomic, copy) NSString *art_title;
@property (nonatomic, copy) NSString *art_type;
@property (nonatomic, copy) NSString *art_dtl_path;
@property (nonatomic, copy) NSString *art_time;

@end
