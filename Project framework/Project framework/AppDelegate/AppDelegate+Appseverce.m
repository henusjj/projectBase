//
//  AppDelegate+initWithRootController.m
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "AppDelegate+Appseverce.h"

@implementation AppDelegate (Appseverce)
-(void)initWithRootView{

    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    MainTabbarController *vc =[[MainTabbarController alloc]init];
    CYLTabBarController *tabVc = vc.mainTabBar;
   //处理相关登录逻辑。。。
    
    self.window.rootViewController=tabVc;
    self.window.backgroundColor=[UIColor whiteColor];


    [self.window makeKeyAndVisible];
}

- (void)initThirdLibKeyBoard {
    //设置为文字
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = NSLocalizedString(@"完成", nil);
    //控制点击背景是否收起键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
        
        switch (networkStatus) {
                // 未知网络
            case PPNetworkStatusUnknown:
                DLog(@"网络环境：未知网络");
                // 无网络
            case PPNetworkStatusNotReachable:
                DLog(@"网络环境：无网络");
                KPostNotification(KNotificationNetWorkStateChange, @NO);
                break;
                // 手机网络
            case PPNetworkStatusReachableViaWWAN:
                DLog(@"网络环境：手机自带网络");
                // 无线网络
            case PPNetworkStatusReachableViaWiFi:
                DLog(@"网络环境：WiFi");
                KPostNotification(KNotificationNetWorkStateChange, @YES);
                break;
        }
        
    }];
    
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            DLog(@"windowsLevel------------%f",tmpWin.windowLevel);
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

@end
