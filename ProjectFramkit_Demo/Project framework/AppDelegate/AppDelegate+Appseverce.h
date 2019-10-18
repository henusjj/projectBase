//
//  AppDelegate+initWithRootController.h
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import "AppDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Appseverce)
-(void)initWithRootView;
- (void)initThirdLibKeyBoard;
//监听网络状态
- (void)monitorNetworkStatus;

/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;

@end

NS_ASSUME_NONNULL_END
