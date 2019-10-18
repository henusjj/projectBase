//
//  AppDelegate.m
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Appseverce.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

//程序启动完成调用此方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initWithRootView];
    
    return YES;
}

//2.应用程序将要进入非活动状态，即将进入后台,在此期间，应用程序不接收消息或事件，比如来电话了等一些请求
- (void)applicationWillResignActive:(UIApplication *)application {
   
}

//3.如果程序支持后台运行的话，当程序被推送到后台的时候调用。所以要设置后台继续运行，在这个方法里设置即可
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

//4.当程序从后台将要重新回到前台时候调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
}

//5.应用程序已进入前台，处于活动状态
- (void)applicationDidBecomeActive:(UIApplication *)application {
}

//6.程序将要退出是被调用，通常是用来保存数据和一些退出前的清理工作。这个需要要设置UIApplicationExitsOnSuspend的键值。
- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
