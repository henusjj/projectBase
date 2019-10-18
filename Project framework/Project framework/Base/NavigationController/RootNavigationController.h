//
//  RootNavigationController.h
//  Project framework
//
//  Created by GuoYanjun on 2019/9/27.
//  Copyright © 2019年 ZXY. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 导航控制器基类
 */
@interface RootNavigationController : UINavigationController

/*!
 *  返回到指定的类视图
 *
 *  @param ClassName 类名
 *  @param animated  是否动画
 */
-(BOOL)popToAppointViewController:(NSString *)ClassName animated:(BOOL)animated;


@end
