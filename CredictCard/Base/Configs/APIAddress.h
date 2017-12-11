//
//  APIAddress.h
//  ganguo
//
//  Created by ganguo on 13-7-8.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//

//SKU  MengYa

//(57)
////#ifdef DEBUG
// 本地
//#define API_HOST @"http://192.168.1.105:8080"
////本地图片
//#define API_IMAGE_HOST  [NSString stringWithFormat:@"%@/html/goaling/images/upload/logins", API_HOST]
////老师头像图片
//#define API_Teacher_IMAGE_HOST [NSString stringWithFormat:@"%@/html/goaling/images/upload/logins", API_HOST]
////视频
//#define API_video_Host [NSString stringWithFormat:@"%@/html/goaling/videos/teacher", API_HOST]
//
////才艺视频
//#define API_talent_video_Host [NSString stringWithFormat:@"%@/html/goaling/videos/video", API_HOST]
//
////才艺视频图片路径
//#define API_talent_videoImage_Host [NSString stringWithFormat:@"%@/html/goaling/videos/images", API_HOST]
////广告图片
//#define API_advertisement_IMAGE_HOST [NSString stringWithFormat:@"%@/html/goaling/images/upload/advertisement", API_HOST]
////资格证明
//#define API_qualification_IMAGE_HOST [NSString stringWithFormat:@"%@/html/goaling/images/upload/qualification", API_HOST]
////学习场景
//#define API_learningscene_IMAGE_HOST [NSString stringWithFormat:@"%@/html/goaling/images/upload/learningscene", API_HOST]
////活动图片
//#define API_gactivities_IMAGE_HOST  [NSString stringWithFormat:@"%@/html/goaling/images/upload/gactivities", API_HOST]
////活动导师头像
//#define API_gactivitieTeacher_IMAGE_HOST  [NSString stringWithFormat:@"%@/html/goaling/images/upload/activeteache", API_HOST]
////活动分享链接
//#define API_activityDetailShare_HOST [NSString stringWithFormat:@"%@/html/goaling/fenxian/fx.html", API_HOST]
//
////视频分享链接
//#define API_videoDetailShare_HOST [NSString stringWithFormat:@"%@/html/goaling/fenxian/video.html", API_HOST]
//
////才艺视频分享链接
//#define API_talentVideoDetailShare_HOST [NSString stringWithFormat:@"%@/html/goaling/fenxian/uservideo.html", API_HOST]
//
////推广链接
//#define API_extendShare_HOST [NSString stringWithFormat:@"%@/html/goaling/invite/invite.html", API_HOST]
////


//////////
//阿里云
#define API_HOST @"https://www.duoyimeng.com"
//阿里云图片
#define API_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/logins"
//老师头像图片
#define API_Teacher_IMAGE_HOST @"http://www.duoyimeng.com/html/goaling/images/upload/logins"
////视频
#define API_video_Host @"https://www.duoyimeng.com/html/goaling/videos/teacher"
////才艺视频
#define API_talent_video_Host @"https://www.duoyimeng.com/html/goaling/videos/video"
//才艺视频图片路径
#define API_talent_videoImage_Host @"https://www.duoyimeng.com/html/goaling/videos/images"

//广告图片
#define API_advertisement_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/advertisement"
//资格证明
#define API_qualification_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/qualification/"
//学习场景
#define API_learningscene_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/learningscene/"
///活动图片
#define API_gactivities_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/gactivities"
////活动导师头像
#define API_gactivitieTeacher_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/activeteacher"
//活动分享链接
#define API_activityDetailShare_HOST @"https://www.duoyimeng.com/html/goaling/fenxian/fx.html"
//视频分享链接
#define API_videoDetailShare_HOST @"https://www.duoyimeng.com/html/goaling/fenxian/video.html"
//
//才艺视频分享链接
#define API_talentVideoDetailShare_HOST @"https://www.duoyimeng.com/html/goaling/fenxian/uservideo.html"

//推广链接
#define API_extendShare_HOST @"https://www.duoyimeng.com/html/goaling/invite/invite.html"

//教师主页
#define  API_TeacherHomePageShare_HOST @"https://www.duoyimeng.com/html/goaling/homepage/teacher_details.html"

//学生主页
#define  API_UserHomePageShare_HOST @"https://www.duoyimeng.com/html/goaling/homepage/student_details.html"


////公共设置
#define APP_key @"59334e721bcd31"
#define APP_scode @"15ca7554e8cb486f3b8cbe1fa166c75b"
// [NSString md5:[APP_key stringByAppendingString:@"trans"]]

//MD5加密（APP_key+”weicai”）
#define API_APP_BASE_URL @"goaling"
#define API_BASE_URL [NSString stringWithFormat:@"%@/%@", API_HOST, API_APP_BASE_URL]
#define API_QR_BASE_URL [NSString stringWithFormat:@"%@/image", API_BASE_URL]

//接口
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]

//图片
#define kAPIImageFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//老师头像
#define kAPITeacherImageFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_Teacher_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//视频路径
#define kAPIVideoFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_video_Host, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//才艺视频路径
#define kAPITalentVideoFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_talent_video_Host, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]


//才艺视频图片路径
#define kAPITalent_videoImageFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_talent_videoImage_Host, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]


//轮播图
#define kAPIadvertisementFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_advertisement_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//资格证明
#define kAPIqualificationFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_qualification_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//学习场景
#define kAPIlearningsceneFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_learningscene_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//活动图片
#define kAPIGactivitiesUrl(url) [[NSString stringWithFormat:@"%@/%@", API_gactivities_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//活动导师头像
#define kAPIGactivitieTeacherUrl(url) [[NSString stringWithFormat:@"%@/%@", API_gactivitieTeacher_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//活动分享链接
#define KActivityDetailShareUrl(url) [[NSString stringWithFormat:@"%@?%@",API_activityDetailShare_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//视频分享链接
#define KVideoDetailShareUrl(url) [[NSString stringWithFormat:@"%@?%@",API_videoDetailShare_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//才艺视频分享链接
#define KTalentVideoDetailShareUrl(url) [[NSString stringWithFormat:@"%@?%@",API_talentVideoDetailShare_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
//推广链接
#define KextendShareUrl(url) [[NSString stringWithFormat:@"%@?%@",API_extendShare_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//教师主页分享链接
#define KTeacherHomePageShareUrl(url) [[NSString stringWithFormat:@"%@?%@",API_TeacherHomePageShare_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//学生主页分享链接
#define KUserHomePageShareUrl(url) [[NSString stringWithFormat:@"%@?%@",API_UserHomePageShare_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]


#define video_testUrl @"http://1253712797.vod2.myqcloud.com/e8f61ed3vodtransgzp1253712797/863fe8399031868222929787287/f0.f20.mp4"

//


#import "HJUser.h"
#import "HXTeacherLoginModel.h"
//#define article_detail_url  @"http://192.168.0.105/my/menya/Mengya/index.html"
//文章详情
#define article_detail_url  @"http://www.duoyimeng.com/html/goaling/mengya/index.html"

//通知
#define KJust_WIFI_Play_Notification @"KJust_WIFI_Play_Notification" //开启4G网络下播放通知

//微信APPStore URL
#define KWX_APPStore_URL @"https://itunes.apple.com/cn/app/微信/id414478124?mt=8"
//#define KWX_APPStore_URL @"https://itunes.apple.com/cn/app/qq/id444934666?mt=8"

//一对多微信支付
#define KWX_Pay_Sucess_Notification @"KWX_Pay_Sucess_Notification" //微信支付成功通知
#define KWX_Pay_Fail_Notification @"KWX_Pay_Fail_Notification" //微信支付失败通知

//一对一微信支付
#define KWX_OneToOne_Pay_Sucess_Notification @"KWX_OneToOne_Pay_Sucess_Notification" //微信支付成功通知
#define KWX_OneToOne_Pay_Fail_Notification @"KWX_OneToOne_Pay_Fail_Notification" //微信支付失败通知

//搜索关键字
#define KWX_KeyWord_Serach_Notification @"KWX_KeyWord_Serach_Notification" //搜索通知
//搜索关键字
#define KWX_KeyWord_One_More_Serach_Notification @"KWX_KeyWord_One_More_Serach_Notification" //搜索通知

//接收通知成功
#define KDidReceiveMessageNotification @"KDidReceiveMessageNotification"


//wiFi开关是否开启通知
#define KWIFI_OPen_Notification @"KWI-FI_OPen_Notification"
#define KSwi_State @"swiState"


#define KWX_UpdateIcon_Notification @"KWX_UpdateIcon_Notification" //更新头像通知

//个人中心默认头像
#define Kplaceholder_info @"placeholder_info"
//课程列表默认头像
#define Kplaceholder_list @"placeholder_list"


//在内购项目中创的商品单号
#define ProductID_MENYA @"ProductID_MENYA"//20

#define KpageSize 15

//用户表名
#define User_TableName @"user_table"
//本人表名
#define Mine_TableName @"mine_table"
//数据库名
#define Common_DB @"common.db"
//缓存名
#define BaseCache_Name @"BaseCache"


/**
 *  登录注册
 */
//1.1获取验证码
#define API_GET_VERIFY_CODE API_SUB_URL(@"sendcodesms/sms")//*
//1.2手机（账号）唯一性验证
#define API_CHECK_PHONE API_SUB_URL(@"logins/getAcc")//*
//1.3注册
#define API_REGISTER API_SUB_URL(@"logins/add")//*
//1.4登录
#define API_LOGIN API_SUB_URL(@"logins/login")//*
//1.5判断是否在登录状态
#define API_IS_LOGIN API_SUB_URL(@"logins/isLogin")
//1.6修改密码
#define API_GET_EDIT_PWD API_SUB_URL(@"logins/editPwd")
//1.7微信登录
#define API_WX_LOGIN API_SUB_URL(@"logins/wxadd")
//1.8绑定手机号
#define API_BIND_Phone API_SUB_URL(@"logins/addacc")
//1.9忘记密码
#define API_GET_FORGET_PWD API_SUB_URL(@"logins/editPassword")
////1.10微信绑定手机号
//#define API_BIND_WEIXIN API_SUB_URL(@"user/bindWeixin.do")
//1.6教师修改密码
#define API_Teacher_editPassword API_SUB_URL(@"logins/editPwd")
//1.6教师忘记密码
#define API_Teacher_forgetPwd API_SUB_URL(@"logins/editPassword")
//1.7协议显示状态
#define API_showstatus API_SUB_URL(@"showstatus/list_anon")
//1.8查看教师是否已经提交教师认证接口
#define API_teacher_getApply API_SUB_URL(@"teacher/getApply")
//1.9提交教师申请资料
//#define API_teacher_editApply API_SUB_URL(@"teacher/editApply")
//1.10微信登录没有账号
#define API_WX_addacc API_SUB_URL(@"logins/addacc")
//1.11查看活动标注接口
#define API_activetagging API_SUB_URL(@"activetagging/detail_anon")
//1.12绑定微信openid接口
#define API_editOpenid API_SUB_URL(@"logins/editOpenid")
//1.13更改手机号
#define API_editPhone API_SUB_URL(@"logins/editPhone")
//1.14获取须知文档
#define API_tips_list API_SUB_URL(@"tips/list_anon")
//1.15修改课程提前结束接口
#define API_editStatus API_SUB_URL(@"curriculum/editStatus")
//1.16(删除)
#define API_editShow API_SUB_URL(@"curriculum/editShow")
//1.17查看订单退款失败原因接口
#define API_refundfaileddesc API_SUB_URL(@"refundfaileddesc/detail_anon")
//1.18邀请榜
#define API_invitationList API_SUB_URL(@"logins/invitationList")
//1.19我邀请的人的列表
#define API_list_anon API_SUB_URL(@"logins/list_anon")
//1.20删除视频接口
#define API_talentvideo_editShow API_SUB_URL(@"talentvideo/editShow")
//1.21我的消息
#define API_myinformation_list API_SUB_URL(@"myinformation/list_anon")
//1.22系统消息
#define API_notice_list API_SUB_URL(@"notice/list_anon")
//1.23查看各个未读消息
#define API_getUnread API_SUB_URL(@"myinformation/getUnread")
//1.24修改消息阅读状态
#define API_editUnread API_SUB_URL(@"myinformation/editUnread")
//1.25修改系统消息阅读状态
#define API_notice_editUnread API_SUB_URL(@"notice/editUnread")
//1.26通过接收验证码登录接口
#define API_codeLogin API_SUB_URL(@"logins/codeLogin")



/**
 *  首页
 */
//2.1获取轮播图
#define API_GET_LIST_anon  API_SUB_URL(@"advertisement/list_anon")
//2.2教学类型
#define API_teachingtype_LIST  API_SUB_URL(@"teachingtype/list_anon")
//2.3萌艺精选接口
#define API_videos_List  API_SUB_URL(@"videos/list_anon")
//2.4视频详情接口
#define API_videos_Detail_List  API_SUB_URL(@"videos/detail_anon")
//2.5添加点赞
#define API_givethumbs  API_SUB_URL(@"givethumbs/add")
//2.6添加分享
#define API_editShare  API_SUB_URL(@"videos/editShare")
//2.7添加视频播放量
#define API_editPlay  API_SUB_URL(@"videos/editPlay")
//2.8添加视频评论接口
#define API_videoreview_add  API_SUB_URL(@"videoreview/add")
//2.9视频评论列表接口
#define API_videoreview_list  API_SUB_URL(@"videoreview/list_anon")
//2.10系统公告接口
#define API_announcement_list  API_SUB_URL(@"announcement/list_anon")

/**
 *  发现
 */
//3.1课程列表接口/查看一对一课程列表(curriculumtype:curriculum-type-ydy)/用户收藏的课程
#define API_curriculum_list_anon API_SUB_URL(@"curriculum/list_anon")
//3.2课程详情接口
#define API_curriculum_detail API_SUB_URL(@"curriculum/detail_anon")
//3.3我的优惠券列表/查看课程可使用的优惠券
#define API_curriculumcoupon_collection API_SUB_URL(@"curriculumcoupon_collection/list_anon")
//3.3查看用户是否领取了优惠券
#define API_is_getCoupon API_SUB_URL(@"curriculumcoupon_collection/getCoupon")
//3.4领取课程优惠券接口
#define API_getCoupon API_SUB_URL(@"curriculumcoupon_collection/add")
//3.5获取教师详情
#define API_teacher_detail API_SUB_URL(@"teacher/detail_anon")
//3.6获取课程大纲
#define API_coursechapters API_SUB_URL(@"coursechapters/list_anon")
//3.7添加课程评论
#define API_curriculumcomment_add API_SUB_URL(@"curriculumcomment/add")
//3.8评论列表接口
#define API_curriculumcomment_list API_SUB_URL(@"curriculumcomment/list_anon")
//3.9用户添加课程收藏
#define API_curriculum_collection API_SUB_URL(@"curriculum_collection/add")
//3.10查看用户是否收藏该课程
#define API_getUserCurriculum API_SUB_URL(@"curriculum_collection/getUserCurriculum")


/**
 *  才艺
 */
//3.1才艺类型接口
#define API_talentvideotype_list  API_SUB_URL(@"talentvideotype/list_anon")
//3.2添加才艺视频接口
#define API_talentvideo_add  API_SUB_URL(@"talentvideo/add")
//3.3才艺视频列表
#define API_talentvideo_list  API_SUB_URL(@"talentvideo/list_anon")
//3.4查看才艺展示视频周排行榜接口
#define API_talentvideo_date API_SUB_URL(@"talentvideo/date_anon")
//3.5才艺视频详情接口
#define API_talentvideo_detail API_SUB_URL(@"talentvideo/detail_anon")
//3.6添加才艺展示视频点赞接口
#define API_talentfabulous_add API_SUB_URL(@"talentfabulous/add")
//3.7添加才艺视频观看量
#define API_talentvideo_addWatchnumber API_SUB_URL(@"talentvideo/addWatchnumber")
//3.8添加才艺视频分享量
#define API_talentvideo_addSharenumber API_SUB_URL(@"talentvideo/addSharenumber")
//3.9添加才艺视频评论接口
#define API_talentcomment_add API_SUB_URL(@"talentcomment/add")
//4.0根据才艺视频查看评论接口
#define API_talentcomment_list API_SUB_URL(@"talentcomment/list_anon")
//4.1删除才艺视频接口
#define API_talentvideo_delete API_SUB_URL(@"talentvideo/delete")


/**
 *  活动
 */
//3.1活动接口
#define API_gactivities_list  API_SUB_URL(@"gactivities/list_anon")
//3.2活动详情接口
#define API_gactivities_detail  API_SUB_URL(@"gactivities/detail_anon")
//3.3活动导师接口
#define API_activeteacher_list  API_SUB_URL(@"activeteacher/list_anon")
//3.4报名接口
#define API_applicant_add  API_SUB_URL(@"applicant/add")
//3.5添加访问量
#define API_gactivities_editVisit  API_SUB_URL(@"gactivities/editVisit")
//3.6添加活动分享量
#define API_gactivities_editShare  API_SUB_URL(@"gactivities/editShare")
//3.7导师详情接口
#define API_activeteacher_detail  API_SUB_URL(@"activeteacher/detail_anon")
//3.8导师全部学员
#define API_applicant_list  API_SUB_URL(@"applicant/list_anon")
//3.9添加聊天显示的课程接口
#define API_chatlog_add  API_SUB_URL(@"chatlog/add")
//3.10添加聊天显示的课程接口
#define API_chatlog_getCurriculumId API_SUB_URL(@"chatlog/getCurriculumId")
//3.11活动视频列表
#define API_activityVideoList API_SUB_URL(@"talentvideo/activeVideoList")
//3.12模块显示状态接口
#define API_moduleselection API_SUB_URL(@"moduleselection/detail_anon")


/**
 *  我的
 */
//4.1查看用户个人信息
#define API_GET_USER_INFO API_SUB_URL(@"users/initEdit")
//4.2修改用户信息
#define API_EDIT_USER_INFO API_SUB_URL(@"users/edit")
//4.3用户头像上传
#define API_media_upload API_SUB_URL(@"users/media_upload")
//4.4用户反馈
#define API_users_feedback API_SUB_URL(@"users_feedback/add")
//4.5查看我的课程接口
#define API_getPurchase API_SUB_URL(@"curriculum/getPurchase")
//4.6订单列表接口
#define API_transactionrecord_list API_SUB_URL(@"transactionrecord/list_anon")
//4.7订单详情接口
#define API_transactionrecord_detail API_SUB_URL(@"transactionrecord/detail_anon")
//4.8查看教师是否存在一对一课程接口
#define API_curriculum_initEdit API_SUB_URL(@"curriculum/initEdit")
//4.9添加一对一课程接口
#define API_curriculum_oneadd API_SUB_URL(@"curriculum/oneadd")
//4.10教师查看提现列表
#define API_withdrawals_list API_SUB_URL(@"withdrawals/list_anon")
////4.11教师提现接口
//#define API_withdrawals_add API_SUB_URL(@"withdrawals/add")
//4.12申请提现
#define API_GET_withdrawals API_SUB_URL(@"withdrawals/add")

//4.13提现记录
#define API_withdrawals_list API_SUB_URL(@"withdrawals/list_anon")
//4.14退款
#define API_applyrefund API_SUB_URL(@"transactionrecord/applyrefund")
//4.15删除收藏
#define API_collectionDelete API_SUB_URL(@"curriculum_collection/delete")

#define API_GET_browseCourse API_SUB_URL(@"myinformation/browseCourse")
//3.4我的资产
#define API_GET_myAsset API_SUB_URL(@"myinformation/myAsset")
//3.5系统通知
#define API_systemnotification API_SUB_URL(@"systemnotification/list_anon")
//3.6查看学生报名活动
#define API_getAlready API_SUB_URL(@"gactivities/getAlready")
//3.7查看余额接口
#define API_getBalance API_SUB_URL(@"logins/getBalance")
//3.8我的才艺展示视频
#define API_mytalentvideo API_SUB_URL(@"talentvideo/logins_list_anon")
//3.9优惠券已使用
#define API_coupon_list_anon_ysy API_SUB_URL(@"curriculumcoupon_collection/list_anon_ysy")
//3.10优惠券已过期
#define API_coupon_list_anon_ygq  API_SUB_URL(@"curriculumcoupon_collection/list_anon_ygq")
//3.11优惠券未使用未过期
#define API_coupon_list_anon  API_SUB_URL(@"curriculumcoupon_collection/list_anon")


/**
 *  教师
 */
//5.1查看教师账号唯一性
#define API_getTeacheracc API_SUB_URL(@"logins/getAcc")
//5.2教师注册
#define API_teacher_add API_SUB_URL(@"goaling/logins/add")
//5.3教师登录
#define API_teacher_login API_SUB_URL(@"logins/login")
//5.4教师判断是否登录
#define API_teacher_isLogin API_SUB_URL(@"logins/isLogin")
//5.6教师图片上传接口
#define API_teacher_media_upload API_SUB_URL(@"users/media_upload")
//5.7教师图片上传接口
#define API_curriculum_add API_SUB_URL(@"curriculum/add")
//5.8获取教师信息接口
#define API_teacher_initEdit API_SUB_URL(@"teacher/initEdit")
//5.9申请教师接口
#define API_teacher_editApply API_SUB_URL(@"teacher/edit")
//5.9修改教师信息
#define API_teacher_edit API_SUB_URL(@"teacher/editAtion")
//5.10添加课程接口
#define API_curriculum_add API_SUB_URL(@"curriculum/add")
//5.11设置宣传视频接口
#define API_video_upload API_SUB_URL(@"displayvideo/video_upload")
//5.12教师扫描修改状态接口
#define API_transactionrecord_scann API_SUB_URL(@"transactionrecord/scanning")
//5.13学生按钮修改课程状态接口
#define API_transactionrecord_change API_SUB_URL(@"transactionrecord/change")
//5.14添加资格证明图片
#define API_qualification_add API_SUB_URL(@"qualification/add")
//5.15删除资格证明图片
#define API_qualification_delete API_SUB_URL(@"qualification/delete")
//5.16添加学习场地图片
#define API_learningscene_add API_SUB_URL(@"learningscene/add")
//5.17删除学习场地图片
#define API_learningscene_delete API_SUB_URL(@"learningscene/delete")
//5.18查看邀请码是否存在
#define API_getInvitationcode API_SUB_URL(@"teacher/getInvitationcode")
//5.19查看教师课程接口
#define API_teacherCurriculum API_SUB_URL(@"curriculum/list_anon_nn")
//5.20查看教师邀请的人
#define API_teacherInvit API_SUB_URL(@"teacher/list_anon")
//5.21删除教师和学生账号
#define API_deleteTeacherAndUsers API_SUB_URL(@"logins/delete")
//5.22查看教师审核失败说明接口
#define API_failuredecl_detail API_SUB_URL(@"failuredecl/detail_anon")
//5.23帮助
#define API_problemtype_list API_SUB_URL(@"problemtype/list_anon")


//5.24添加关注
#define API_follow_add API_SUB_URL(@"follow/add")
//5.25取消关注
#define API_follow_delete API_SUB_URL(@"follow/delete")
//5.25教师个人主页接口
#define API_teacher_homePage API_SUB_URL(@"teacher/detail")
//5.26学生主页接口
#define API_user_homePage API_SUB_URL(@"users/detail")
//5.27查看关注列表
#define API_follow_list API_SUB_URL(@"follow/list_anon")



/**
 *  支付
 */

//7.1微信支付
#define API_GET_PAY_CHARGE  API_SUB_URL(@"app/wxtopay/wxtopay_anon")

