//
//  ZXMaiAnAPI.h
//  ZXChunYu
//
//  Created by yunmu on 15/12/16.
//  Copyright © 2015年 陈知行. All rights reserved.
//

#ifndef ZXMaiAnAPI_h
#define ZXMaiAnAPI_h

// 请求
static NSString *const ZXMaiAn_HTTP_REQUEST_PREFIX = @"http://114.215.136.156/varix";
// 资源
static NSString *const ZXMaiAn_RESOURCE_PREFIX = @"http://114.215.136.156";

// 医生
static NSString *const getDocsByID = @"/doctor/getDoctorById.do";
static NSString *const getDocsURL = @"/doctor/getDoctorsByNum.do?start_num=0";
static NSString *const getDocFollowerNumURL = @"/doctor/getFocusOnDoc.do?did=";
static NSString *const getDocServeNumURL = @"/doctor/getTalkedUser.do?did=";
static NSString *const getDocCommentsURL = @"/doctor/getEvaluation2Doc.do?";
static NSString *const getDocByNameURL = @"/doctor/getDoctorsByName.do?";
static NSString *const getDocByAreaURL = @"/doctor/getDoctorsByArea.do?";
static NSString *const getDocByTitleURl = @"/doctor/getDoctorsByTitle.do?";

//
static NSString *const followDoctor = @"/user2doctor/addFocus.do";
static NSString *const cancelFollowDoctor = @"/user2doctor/delFocus.do";

// 医院
static NSString *const getHosByNum = @"/hospital/getHospitalsByNum.do?";
static NSString *const getHosByName = @"/hospital/getHospitalsByName.do?";
static NSString *const getHosByArea = @"/hospital/getHospitalsByArea.do?";
static NSString *const getHosByTitle = @"/hospital/getHospitalsByTitle.do?";

// 用户
static NSString *const LoginURL = @"/user/login.do";
static NSString *const getUserInfoByUID = @"/user/getUserInfo2ById.do?";
static NSString *const updateUserInfo = @"/user/updateUserInfo2.do";
static NSString *const isUserRegistered = @"/user/isRegistered.do?";
static NSString *const updateUserPwd = @"/user/updateUserPasswdByUsername.do";
static NSString *const userRegist = @"/user/register.do";
static NSString *const uploadUserAvatar = @"/user/uploadUserPortrait.do";
static NSString *const getFocusedDoc = @"/user/getFocusedDoctors.do?";
static NSString *const getUserPortrait = @"/user/getUserPortraitById.do";
static NSString *const changePwd = @"/user/updateUserPasswd.do";

// 资讯
static NSString *const getArticlesByType = @"/encyclopedia/getArticlesByType.do";

// 产品
static NSString *const getGoods = @"/goods/getGoods.do";

// 首页
static NSString *const getAds = @"/ads/getOnceAds.do"; // 广告
static NSString *const selfCheckURL = @"http://114.215.136.156/html/jmqz_level/jmqz_djpd.html"; //

#endif /* ZXMaiAnAPI_h */
