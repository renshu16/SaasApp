//
//  CommonString.h
//  SaasApp
//
//  Created by ToothBond on 15/11/6.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#ifndef CommonString_h
#define CommonString_h


#endif /* CommonString_h */

#pragma mark - global
#define DESSecretKey        @"com.aiyacloud.app"

#define AppVersion          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define AppBuild            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define DEVICE_OS           [[UIDevice currentDevice] model]
#define DEVICE_VERSION      [[[UIDevice currentDevice] systemVersion] floatValue]


#pragma mark - message warning
#define request_success         @"请求成功"
#define request_submit_success  @"提交成功"
#define network_error           @"网络连接异常"
#define request_error           @"数据异常，请重试"

#define tips_no_data            @"没有数据"
#define tips_no_schedule        @"您目前还没有工作安排"
#define tips_unproperly_bes     @"医生该时间段没有排班\n是否确定预约？"

#define input_phone_error       @"请输入正确的手机号"
#define input_authcode_error    @"请输入验证码"
#define input_error             @"请输入内容"
#define input_psw_lenght_error  @"请输入至少6位长度密码"
#define input_psw_error         @"请输入密码"
#define input_psw_new_error     @"请输入新密码"
#define input_psw2_error        @"2次输入的密码不一致"
#define input_oldpsw_error      @"请输入旧密码"
#define input_oldpsw_invalid    @"旧密码不正确"
#define request_success_modifypsw   @"新密码修改成功 请重新登录"
#define input_content_error     @"请输入内容"
#define input_login_error       @"用户名或密码错误"


#define validate_authcode_error @"验证码出错"

#define alert_ok                @"确定"
#define alert_check             @"查看"
#define alert_cancel            @"取消"

#define boolean_true            @"true"
#define boolean_false           @"false"


#pragma mark - Notifycation
//#define Notify_Matter_Result   @"Matter_Result";
/**
 *  排班列表单元格点击事件
 */
#define Notify_Sch_Cell_Event       @"Sch_Cell_Event"
#define Notify_Sch_Cell_Event_Key   @"Sch_Cell_Event_Key"
#define Notify_Bes_New              @"Bes_New"

#pragma mark - 预约
#define title_bes_main          @"预约"
#define title_bes_detail        @"预约详情"
#define title_bes_create        @"新增预约"
#define title_bes_matter        @"预约事项"




#pragma mark - 排班
#define title_sch_main @"排班"





#pragma mark - 我的
#define title_user_main      @"我的"
#define title_user_forgetpsw @"找回密码"
#define title_user_newpsw    @"设置新密码"

#define title_mine_modifypsw @"修改密码"
#define title_mine_feedback  @"意见反馈"
#define title_mine_cache     @"清除缓存"
#define title_mine_version   @"版本号"
#define title_mine_about     @"关于"

#pragma mark - date string
#define SECCONDS_IN_MINUTES             60
#define MINUTES_IN_HOUR                 60
#define HOURS_IN_DAY                    24
#define DAY_IN_MINUTES                  1440
#define DAYS_IN_WEEK                    7


