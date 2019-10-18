//
//  UserInfoManager.h
//  BaseKit
//
//  Created by GuoYanjun on 2019/4/1.
//  Copyright © 2019年 shiyujin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoManager : NSObject
/**
 * 个人信息最全info
 *
 */

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *name;//'昵称:唯一',
@property(nonatomic,copy)NSString *psd;//密码', #加密存储
@property(nonatomic,copy)NSString *phone;//手机号
@property(nonatomic,copy)NSString *mail;//邮箱
@property(nonatomic,copy)NSString *male;//性别
@property(nonatomic,copy)NSString *imgDefault;//默认图片
@property(nonatomic,copy)NSString *imgUploaded;//用户上传图片，可变---
@property(nonatomic,copy)NSString *level;//用户等级 0-10级，由登陆次数、贡献度等综合计算
@property(nonatomic,copy)NSString *levintegralel;

@property(nonatomic,copy)NSString *createTime;//创建时间
@property(nonatomic,copy)NSString *modefyTime;//修改时间

@property(nonatomic,copy)NSString *token;//用户唯一表示



/**
 * 单例对象
 *
 */
+(instancetype)UserShareManager;

/**
 * 通过单例对象初始化工具类
 *
 */
+(void)configInfo:(NSDictionary *)infoDic;

/**
 * 用户退出登录操作
 *
 */
+(void)LoginOut;

@end

NS_ASSUME_NONNULL_END
