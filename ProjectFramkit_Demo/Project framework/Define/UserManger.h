//
//  UserManger.h
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#ifndef UserManger_h
#define UserManger_h

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window

#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

#define kUserDefaults       [NSUserDefaults standardUserDefaults]
//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

#define kUserinfoManager    [UserInfoManager UserShareManager]

#endif /* UserManger_h */
