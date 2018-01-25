//
//  APIAddress.h
//  ganguo
//
//  Created by ganguo on 13-7-8.
//  Copyright (c) 2013年 ganguo. All rights reserved.
//

//SKU  MengYa

//(57)
//#ifdef DEBUG

//正式
#define API_HOST @"http://card.elevo.cn"

// 测试
//#define API_HOST @"http://dm-card.elevo.cn"

//本地图片
#define API_IMAGE_HOST  [NSString stringWithFormat:@"%@/html/goaling/images/upload/logins", API_HOST]
//老师头像图片
#define API_Teacher_IMAGE_HOST [NSString stringWithFormat:@"%@/html/goaling/images/upload/logins", API_HOST]
//推广链接
#define API_extendShare_HOST [NSString stringWithFormat:@"%@/html/goaling/invite/invite.html", API_HOST]
//

////////////
////阿里云
//#define API_HOST @"https://www.duoyimeng.com"
////阿里云图片
//#define API_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/logins"
////老师头像图片
//#define API_Teacher_IMAGE_HOST @"http://www.duoyimeng.com/html/goaling/images/upload/logins"
//////视频
//#define API_video_Host @"https://www.duoyimeng.com/html/goaling/videos/teacher"
//////才艺视频
//#define API_talent_video_Host @"https://www.duoyimeng.com/html/goaling/videos/video"
////才艺视频图片路径
//#define API_talent_videoImage_Host @"https://www.duoyimeng.com/html/goaling/videos/images"
//
////广告图片
//#define API_advertisement_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/advertisement"
////资格证明
//#define API_qualification_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/qualification/"
////学习场景
//#define API_learningscene_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/learningscene/"
/////活动图片
//#define API_gactivities_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/gactivities"
//////活动导师头像
//#define API_gactivitieTeacher_IMAGE_HOST @"https://www.duoyimeng.com/html/goaling/images/upload/activeteacher"
////活动分享链接
//#define API_activityDetailShare_HOST @"https://www.duoyimeng.com/html/goaling/fenxian/fx.html"
////视频分享链接
//#define API_videoDetailShare_HOST @"https://www.duoyimeng.com/html/goaling/fenxian/video.html"
////
////才艺视频分享链接
//#define API_talentVideoDetailShare_HOST @"https://www.duoyimeng.com/html/goaling/fenxian/uservideo.html"
//
////推广链接
//#define API_extendShare_HOST @"https://www.duoyimeng.com/html/goaling/invite/invite.html"
//
////教师主页
//#define  API_TeacherHomePageShare_HOST @"https://www.duoyimeng.com/html/goaling/homepage/teacher_details.html"
//
////学生主页
//#define  API_UserHomePageShare_HOST @"https://www.duoyimeng.com/html/goaling/homepage/student_details.html"
//
//
////公共设置
#define APP_key @"59334e721bcd31"
#define APP_scode @"15ca7554e8cb486f3b8cbe1fa166c75b"
// [NSString md5:[APP_key stringByAppendingString:@"trans"]]

//MD5加密（APP_key+”weicai”）
#define API_APP_BASE_URL @""
#define API_BASE_URL [NSString stringWithFormat:@"%@", API_HOST]
#define API_QR_BASE_URL [NSString stringWithFormat:@"%@/image", API_BASE_URL]

//接口
#define API_SUB_URL(_url) [NSString stringWithFormat:@"%@/%@", API_BASE_URL, _url]

//
////图片
#define kAPIImageFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_IMAGE_HOST, url]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]]
////老师头像
//#define kAPITeacherImageFromUrl(url) [[NSString stringWithFormat:@"%@/%@", API_Teacher_IMAGE_HOST, url]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//#define video_testUrl @"http://1253712797.vod2.myqcloud.com/e8f61ed3vodtransgzp1253712797/863fe8399031868222929787287/f0.f20.mp4"
//
////


#import "HJUser.h"
//#define article_detail_url  @"http://192.168.0.105/my/menya/Mengya/index.html"
//文章详情
#define article_detail_url  @"http://www.duoyimeng.com/html/goaling/mengya/index.html"

//通知
#define KJust_WIFI_Play_Notification @"KJust_WIFI_Play_Notification" //开启4G网络下播放通知

//微信APPStore URL
#define KWX_APPStore_URL @"https://itunes.apple.com/cn/app/微信/id414478124?mt=8"
//#define KWX_APPStore_URL @"https://itunes.apple.com/cn/app/qq/id444934666?mt=8"

//微信支付
#define KWX_Pay_Sucess_Notification @"KWX_Pay_Sucess_Notification" //微信支付成功通知
#define KWX_Pay_Fail_Notification @"KWX_Pay_Fail_Notification" //微信支付失败通知


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

//缓存名
#define BaseCache_Name @"BaseCache"


/**
 *  链接
 */
//1.1公共链接
#define API_GetCommonUrl   API_SUB_URL(@"Api/ApiCommonUrl/GetCommonUrl")


/**
 *  登录注册
 */
//1.1获取验证码
#define API_SendCode API_SUB_URL(@"Api/ApiUser/SendCode")
//1.2注册
#define API_REGISTER API_SUB_URL(@"Api/ApiLogin/Register")
//1.3登录
#define API_LOGIN API_SUB_URL(@"Api/ApiLogin/Login")
//1.4绑定手机号
#define API_BIND_Phone API_SUB_URL(@"Api/ApiUser/EditUserPhone")
//1.5账户是否存在
#define API_UserIsExist API_SUB_URL(@"Api/ApiLogin/UserIsExist")
//1.6用户是否绑定手机
#define API_UserIsBrankPhone API_SUB_URL(@"Api/ApiUser/UserIsBrankPhone")

/**
 *  首页
 */
//2.1获取首页的其它信息
#define API_GetIndexBase  API_SUB_URL(@"Api/ApiIndex/GetIndexBase")
//2.2获取所有银行
#define API_teachingtype_LIST  API_SUB_URL(@"Api/ApiCard/GetBrankList")
//2.3获取办卡列表
#define API_GetCreateCardList  API_SUB_URL(@"Api/ApiCreateCard/GetCreateCardList")
//2.4获取贷款列表
#define API_GetLoanList  API_SUB_URL(@"Api/ApiLoan/GetLoanList")
//2.5获取银行卡计划（当月第一条）
#define API_GetCardTopPlan  API_SUB_URL(@"Api/ApiCardPlan/GetCardTopPlan")
//2.6获取消费类型
#define API_GetConsumptionType  API_SUB_URL(@"Api/ApiCardPlan/GetConsumptionType")
//2.7点击更换刷卡额度
#define API_GetRefreshPlan  API_SUB_URL(@"Api/ApiCardPlan/GetRefreshPlan")
//2.8计划当天还需操作
#define API_today_CardPlanDetail  API_SUB_URL(@"Api/ApiCardPlanDetail/GetTodayPlan")
//2.9某月刷卡计划
#define API_GetMonthPlan  API_SUB_URL(@"Api/ApiCardPlan/GetMonthPlan")
//2.10设置还清
#define API_SetPlanFinish  API_SUB_URL(@"Api/ApiCardPlanDetail/SetPlanFinish")
//2.7一键还清
#define API_SetAllPlanFinish  API_SUB_URL(@"Api/ApiCardPlanDetail/SetAllPlanFinish")
//2.11消息列表
#define API_GetNoticeList  API_SUB_URL(@"Api/ApiNotice/GetNoticeList")
//2.12消息详细
#define API_GetNoticeDetail  API_SUB_URL(@"Api/ApiNotice/GetNoticeDetail")
//2.13文章分类列表
#define API_GetArticleTypeList  API_SUB_URL(@"Api/ApiArticle/GetArticleTypeList")
//2.14文章列表
#define API_GetArticleList  API_SUB_URL(@"Api/ApiArticle/GetArticleList")
//2.15文章详细
#define API_GetArticleDetail  API_SUB_URL(@"Api/ApiArticle/GetArticleDetail")

//修改消费类型
#define API_EditConsumptionType  API_SUB_URL(@"Api/ApiCardPlan/EditConsumptionType")

/**
 *  发现
 */
//3.1 获取用户信用卡列表
#define API_GetUserAllCardList API_SUB_URL(@"Api/ApiUserCard/GetUserAllCardList")
//3.2 信用卡信息
#define API_GetCardById API_SUB_URL(@"Api/ApiCard/GetCardById")
//3.3 添加信用卡
#define API_AddCard API_SUB_URL(@"Api/ApiCard/AddCard")
//3.5 修改卡账单日
#define API_UpdateStatementDate API_SUB_URL(@"Api/ApiCard/UpdateStatementDate")
//3.6 修改卡还款日
#define API_UpdateRepaymentDate API_SUB_URL(@"Api/ApiCard/UpdateRepaymentDate")
//3.7 修改卡额度
#define API_UpdateCardOverdraft API_SUB_URL(@"Api/ApiCard/UpdateCardOverdraft")
//3.8 修改卡上月应还金额
#define API_UpdateLastMonthConsumption API_SUB_URL(@"Api/ApiCard/UpdateLastMonthConsumption")



/**
 *  我的
 */
//4.1查看用户个人信息
#define API_GET_USER_INFO  API_SUB_URL(@"Api/ApiUser/GetUserInfo")
//4.2修改用户头像
#define API_EditUserHead  API_SUB_URL(@"Api/ApiUser/EditUserHead")
//4.3修改昵称
#define API_EditUserName  API_SUB_URL(@"Api/ApiUser/EditUserName")
//4.4修改手机
#define API_EditUserPhone API_SUB_URL(@"Api/ApiUser/EditUserPhone")
//4.5提现
#define API_UserWithdrawals API_SUB_URL(@"Api/ApiUser/UserWithdrawals")
//4.6设置邮箱和密码
#define API_EditUserMail API_SUB_URL(@"Api/ApiUser/EditUserMail")
//4.7收入记录
#define API_GetUserInComeList API_SUB_URL(@"Api/ApiCommission/GetUserCommissionList")
//4.8团队（下级）列表
#define API_GetSubordinateList API_SUB_URL(@"Api/ApiSubordinate/GetSubordinateList")
//4.9团队销量（下级）列表
#define API_GetSubordinateSaleList API_SUB_URL(@"Api/ApiSubordinate/GetSubordinateSaleList")
//4.10获取已出账单列表
#define API_GetYetPlan API_SUB_URL(@"Api/ApiYetPlan/GetYetPlan")
//4.11会员升级
#define API_GetUserUpgrade API_SUB_URL(@"Api/ApiUserUpgrade/GetUserUpgrade")
//4.12获取海报
#define API_GetQRCode API_SUB_URL(@"Api/ApiUserQRCode/GetQRCode")
//4.13会员当前等级数据
#define API_GetNextUpgrade API_SUB_URL(@"Api/ApiUserUpgrade/GetNextUpgrade")
//4.13获取邮箱密码
#define API_GetUserMail2 API_SUB_URL(@"Api/ApiUser/GetUserMail")
//4.14手动导入当月或上月账单
#define API_GetUserMail API_SUB_URL(@"Api/ApiCardPlan/GetUserMail")

/**
 *  支付
 */

//7.1微信支付
#define API_GET_PAY_CHARGE  API_SUB_URL(@"app/wxtopay/wxtopay_anon")

